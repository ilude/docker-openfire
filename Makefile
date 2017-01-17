all: build

build:
	@docker build --tag=ilude/openfire .

clean:
	@sudo rm -r /pool/volumns/openfire

release: build
	@docker build --tag=ilude/openfire:$(shell cat VERSION) .