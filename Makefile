BINPATH=node_modules/.bin

all: build

build: clean
	$(BINPATH)/webpack --progress --color

clean:
	rm -rf dist/*

dev:
	$(BINPATH)/webpack-dev-server