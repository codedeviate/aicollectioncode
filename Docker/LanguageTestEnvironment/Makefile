

build:
	docker build -t multi-compiler-env .

build-x86_64:
	docker build --platform linux/amd64 -t multi-compiler-env-x86_64 .

run:
	docker run -it --rm multi-compiler-env /bin/bash

run-x86_64:
	docker run --platform linux/amd64 -it --rm multi-compiler-env-x86_64 /bin/bash
