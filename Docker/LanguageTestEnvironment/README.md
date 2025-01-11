# Language Test Environment

This is a Docker image that contains a number of programming languages and tools for testing code.

## Languages and Tools

- gcc
- gfortran
- as
- nasm
- java
- python3
- ruby
- rustc
- go
- node
- perl

## Makefile

### Build

```bash
make build
```

### Run

```bash
make run
```

### Build for x86_64

If you are running Docker on a non x86_64 machine, you can build the image for x86_64 using the following command:

```bash
make build-x86_64
```

### Run for x86_64

If you are running Docker on a non x86_64 machine, you can run the image for x86_64 using the following command:

```bash
make run-x86_64
```