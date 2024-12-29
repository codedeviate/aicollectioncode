# Use the latest minimal Debian image
FROM debian:bookworm-slim

ARG TARGETARCH

RUN case "$TARGETARCH" in \
    "amd64") echo "Installing for amd64";; \
    "arm64") echo "Installing for arm64";; \
    *) echo "Unsupported architecture: $TARGETARCH";; \
    esac

# Install essential tools and necessary packages for multiple programming languages
RUN apt-get update && apt-get install -y --no-install-recommends \
    man \
    bash \
    curl \
    wget \
    build-essential \
    gcc \
    g++ \
    gfortran \
    clang \
    nasm \
    openjdk-17-jdk \
    openjdk-17-jre \
    python3 \
    python3-dev \
    python3-pip \
    perl \
    libperl-dev \
    php-cli \
    php-pear \
    php-mbstring \
    php-curl \
    php-dev \
    npm \
    ruby \
    ruby-dev \
    rustc \
    cargo \
    gdc-12 \
    kotlin \
    ghc \
    cabal-install \
    lua5.4 \
    lua5.4-dev \
    r-base \
    git \
    coreutils \
    libssl-dev \
    composer \
    libcurl4-openssl-dev \
    libxml2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install necessary tools
RUN apt-get update && apt-get install -y gnupg

# Add the Debian repository key non-interactively
RUN curl -fsSL https://ftp-master.debian.org/keys/archive-key-12.asc | gpg --batch --yes --dearmor -o /usr/share/keyrings/debian-archive-keyring.gpg

# Configure the repository
RUN echo "deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://deb.debian.org/debian bookworm main" > /etc/apt/sources.list

# Update apt-get
RUN apt-get update

# Upgrade apt-get
RUN apt-get upgrade -y

# Install Zig
RUN ZIG_VER=`git -c 'versionsort.suffix=-' ls-remote --refs --tags --sort='v:refname' https://github.com/ziglang/zig.git | tail -n1 | awk '{print $2}' | sed 's|refs/tags/||'` && wget -O zig.tar.xz https://ziglang.org/download/${ZIG_VER}/zig-linux-aarch64-${ZIG_VER}.tar.xz
RUN tar -xf zig.tar.xz
RUN find . -maxdepth 2 -name "zig" -exec mv {} /usr/local/bin/ \;
RUN rm -rf zig*.tar.xz zig*

# Install nvm
RUN NVM_VER=`git -c 'versionsort.suffix=-' ls-remote --refs --tags --sort='v:refname' https://github.com/nvm-sh/nvm.git | tail -n1 | awk '{print $2}' | sed 's|refs/tags/||'` && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VER}/install.sh | bash

# Set up NVM environment variables
ENV NVM_DIR=/root/.nvm

# Load NVM and install Node.js and Typescript
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install node && nvm use node && npm install -g typescript"

# Install Deno
RUN curl -fsSL https://deno.land/x/install/install.sh | bash && \
    mv /root/.deno/bin/deno /usr/local/bin/

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin/

# Update Cabal for Haskell package management
RUN cabal update

# Install Swift
RUN curl -s https://archive.swiftlang.xyz/install.sh | bash
RUN apt install -y swiftlang
# Set the working directory
WORKDIR /workspace

# Set the default command to bash
CMD ["bash"]
