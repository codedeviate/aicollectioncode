# Use the official lightweight Alpine Linux image
FROM alpine:latest

# Install necessary packages and compilers
RUN apk update && apk add --no-cache \
    nano \
    build-base \
    gfortran \
    openjdk11-jdk \
    python3 \
    py3-pip \
    ruby \
    rust \
    go \
    nodejs \
    npm \
    perl \
    bash \
    nasm

# Verify installations
RUN gcc --version >> /installed_compilers.txt && \
    gfortran --version >> /installed_compilers.txt && \
    as --version >> /installed_compilers.txt && \
    nasm --version >> /installed_compilers.txt && \
    java -version && >> /installed_compilers.txt \
    python3 --version && >> /installed_compilers.txt \
    ruby --version && >> /installed_compilers.txt \
    rustc --version && >> /installed_compilers.txt \
    go version && >> /installed_compilers.txt \
    node --version && >> /installed_compilers.txt \
    perl --version >> /installed_compilers.txt

# Set the default command to run when starting the container
CMD ["/bin/bash"]
