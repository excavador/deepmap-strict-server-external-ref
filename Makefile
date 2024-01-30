.DEFAULT_GOAL=all

prepare:
	go mod tidy
	go mod download

%/api.go: %.yaml config.yaml
	./deepmap.sh $<

b/api.go: a/api.go

generate: a/api.go b/api.go

build: generate
	go build ./...

all: prepare build