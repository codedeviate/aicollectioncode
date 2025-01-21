package main

import (
	"fmt"
	"net"
	"strings"
)

func main() {
	interfaces, err := net.Interfaces()
	if err != nil {
		fmt.Println("Error fetching network interfaces:", err)
		return
	}

	fmt.Println("Checking for active VPN...")
	vpnActive := false

	for _, iface := range interfaces {
		// Skip inactive interfaces
		if iface.Flags&net.FlagUp == 0 {
			continue
		}
		// Look for common VPN-related interface names
		if strings.Contains(strings.ToLower(iface.Name), "tun") || strings.Contains(strings.ToLower(iface.Name), "tap") {
			ifaceAddrs, err := iface.Addrs()
			if err != nil {
				fmt.Println("Error fetching interface addresses:", err)
				continue
			}

			for _, addr := range ifaceAddrs {
				if strings.Contains(addr.String(), ".") {
					fmt.Printf("IPv4 address found: %s\n", addr.String())
					vpnActive = true
				}
			}

			if vpnActive {
				break
			}
		}
	}

	if vpnActive {
		fmt.Println("VPN is currently active.")
	} else {
		fmt.Println("No active VPN detected.")
	}
}
