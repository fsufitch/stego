PROTO_SOURCES=$(shell find . -name '*.proto')
PROTO_TARGETS=$(shell find . -name '*.proto' | sed 's/\.proto/.pb.go/')
GO_SOURCES := go.mod go.sum $(shell find . -name '*.go')

##########

.PHONY: build clean-build proto clean-proto clean all

all: proto build

build: bin/stego

clean-build:
	rm -rf bin/stego

proto: ${PROTO_TARGETS}

clean-proto:
	find . -name '*.pb.go' -exec rm -rf {} \;

clean: clean-proto
	rm -rf bin/

##########

bin/stego: ${GO_SOURCES} ${PROTO_TARGETS}
	go build -o bin/stego ./cmd/stego/.

%.pb.go: %.proto
	protoc --go_out=$(@D) --go_opt=paths=source_relative $<
