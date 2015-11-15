include config.mk

default: build

.PHONY: clean

build: obj/app.pack.html

dist: distdir obj/app.pack.html
	cp obj/app.pack.html dist/index.html

debug: obj/app.debug.pack.html

clean:
	rm -rf obj dist

cleanall: clean npmclean elmclean

obj/app.js: objdir
	elm make --warn --yes --output obj/app.js src/app.elm

obj/app.min.js: npm obj/app.js
	${compressjs} < obj/app.js > obj/app.min.js

obj/boot.js: objdir
	cp {src,obj}/boot.js

obj/boot.min.js: obj/boot.js
	${compressjs} < obj/boot.js > obj/boot.min.js

obj/app.html: objdir
	cp {src,obj}/app.html

obj/app.pack.html: obj/app.min.js obj/boot.min.js obj/app.html
	scripts/include.awk -v minimized=true < obj/app.html > obj/app.pack.html

obj/app.debug.pack.html: obj/app.js obj/boot.js obj/app.html
	scripts/include.awk < obj/app.html > obj/app.debug.pack.html

npm:
	npm install

npmclean:
	rm -rf node_modules

elmclean:
	rm -rf elm-stuff

objdir:
	mkdir -p obj

distdir:
	mkdir -p dist
