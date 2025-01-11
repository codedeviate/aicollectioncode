setup:
	go mod init github.com/username/LinkedListBTree
	go mod tidy

build:
	go build -o LinkedListBTree main.go

run:
	go run main.go

clean:
	rm LinkedListBTree
	rm go.sum
	rm go.mod

complete: clean setup build
	./LinkedListBTree
