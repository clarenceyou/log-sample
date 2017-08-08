DEPS=go list -f '{{range .TestImports}}{{.}} {{end}}' ./...
GW_PROTO=./gw/proto
GPS_PROTO=./gps/proto

build:
	go build

update-deps:
	rm -rf Godeps
	rm -rf vendor
	go get github.com/tools/godep
	godep save ./...

install-deps:
	go get github.com/tools/godep
	godep restore
	$(DEPS) | xargs -n1 go get -d

fmt:
	bash -c 'go list ./... | grep -v vendor | xargs -n1 go fmt'

test:
	bash -c 'go list ./... | grep -v vendor | xargs -n1 go test -v -cover -timeout=10s'
