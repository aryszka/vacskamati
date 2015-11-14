include config.mk

default: all

.PHONY: clean

all: build

build: elm

elm: objdir
	elm-make --warn --yes --output obj/app.html src/app.elm

clean:
	rm -rf obj dist

objdir:
	mkdir -p obj

distdir:
	mkdir -p dist
