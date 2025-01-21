const std = @import("std");
const net = @import("std").net;
const fmt = @import("std").fmt;
const os = @import("std").os;
const time = @import("std").time;

const ICMP_ECHO_REQUEST = 8;
const ICMP_ECHO_REPLY = 0;
const ICMP_HEADER_SIZE = 8;

const MaxPacketSize = 1024;

const PingResult = struct {
    success: bool,
    time_ms: u64,
};

fn checksum(data: []const u8) u16 {
    var sum: u32 = 0;
    var i: usize = 0;
    while ((i + 1) < data.len) {
        const word = @as(*u16, data[i .. i + 2]);
        sum += @as(u32, word);
        i += 2;
    }

    // If odd number of bytes, add the last byte with 0
    if (i < data.len) {
        sum += u32(data[i]) << 8;
    }

    // Fold sum to 16 bits and complement
    while ((sum >> 16) != 0) {
        sum = (sum & 0xFFFF) + (sum >> 16);
    }
    return @as(u16, ~sum);
}

fn send_ping(socket: *net.Socket, _: net.Address, seq: u16) PingResult {
    var icmp_header: [ICMP_HEADER_SIZE]u8 = undefined;
    var buffer: [MaxPacketSize]u8 = undefined;
    const payload_size = buffer.len - ICMP_HEADER_SIZE;

    const time_start = time.milliTimestamp();
    // Construct ICMP header
    icmp_header[0] = ICMP_ECHO_REQUEST; // Type (Echo Request)
    icmp_header[1] = 0; // Code
    const checksum_placeholder: u16 = 0;
    @as(*u16, &icmp_header[2])[0] = checksum_placeholder;
    @as(*u16, &icmp_header[4])[0] = seq; // ID
    @as(*u16, &icmp_header[6])[0] = seq; // Sequence number

    // Calculate checksum
    const chksum = checksum(icmp_header[0..]);
    @as(*u16, &icmp_header[2])[0] = chksum;

    // Send ICMP request
    std.mem.copy(u8, buffer[0..ICMP_HEADER_SIZE], icmp_header);
    try socket.writeAll(buffer[0 .. ICMP_HEADER_SIZE + payload_size]);

    const time_end = time.milliTimestamp();
    const round_trip_time = time_end - time_start;

    return PingResult{
        .success = true,
        .time_ms = round_trip_time,
    };
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    // const stdout = std.io.getStdOut().writer();
    const argv = std.os.argv;

    if (argv.len < 2) {
        return error.ArgumentsRequired; // At least one argument (hostname or IP) is required
    }

    const host = argv[1];
    //const address: net.Address = if (std.mem.indexOf(u8, host, ".")) {
    const address: net.Address = try net.Address.parseIp4(host, 0); // Parse as IPv4 address if it contains "."
    //    } else {
    //// Resolve the hostname to an IP address
    //const resolved_ip = try net.resolveHostname(host);
    //resolved_ip;
    //};

    const socket = try net.Socket.init(allocator, .{
        .address = address,
        .protocol = .icmp,
        .mode = .blocking,
    });

    const result = try send_ping(&socket, address, 1);
    if (result.success) {
        try fmt.print("Ping success, round trip time: {}ms\n", .{result.time_ms});
    } else {
        try fmt.print("Ping failed\n", .{});
    }

    try socket.close();
}
