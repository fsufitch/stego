GO_SOURCES=go.mod go.sum $(shell find . -name *.go)

bin/stego: ${GO_SOURCES}
	go build -o bin/stego ./cmd/stego/.

##########

.PHONY: clean build
clean:
	rm -rf bin/

build: bin/stego

##########

DEFAULT: build

