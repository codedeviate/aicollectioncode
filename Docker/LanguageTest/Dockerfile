# Use the latest minimal Debian image
FROM debian:bookworm-slim

# Install essential tools and necessary packages for multiple programming languages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    build-essential \
    gcc \
    g++ \
    gfortran \
    clang \
    nasm \
    #openjdk-21-jdk \
    python3 \
    python3-dev \
    python3-pip \
    perl \
    libperl-dev \
    php-cli \
    php-pear \
    php-mbstring \
    php-curl \
    nodejs \
    npm \
    ruby \
    ruby-dev \
    rustc \
    cargo \
    #swiftlang \
    kotlin \
    ghc \
    cabal-install \
    lua5.3 \
    lua5.3-dev \
    r-base \
    git \
    #dotnet-sdk-8.0 \
    coreutils \
    libssl-dev \
    #zig \
    composer \
    libcurl4-openssl-dev \
    libxml2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Deno
RUN curl -fsSL https://deno.land/x/install/install.sh | bash && \
    mv /root/.deno/bin/deno /usr/local/bin/

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin/

# Install the latest npm and TypeScript globally
RUN npm install -g npm typescript

# Update Cabal for Haskell package management
RUN cabal update

# Set the working directory
WORKDIR /workspace

# Set the default command to bash
CMD ["bash"]
