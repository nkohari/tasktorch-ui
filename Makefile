BINPATH=node_modules/.bin
OUTPATH=dist

all: build

build: clean
	$(BINPATH)/webpack --progress --color

clean:
	rm -rf $(OUTPATH)/*

dev:
	$(BINPATH)/webpack-dev-server --devtool eval --progress --colors --hot --content-base $(OUTPATH) --port 8888 --history-api-fallback
