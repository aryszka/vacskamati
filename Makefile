include config.mk

default: build

.PHONY: clean

build: obj/app.pack.html

dist: distdir obj/app.pack.html
	cp obj/app.pack.html dist/index.html

clean:
	rm -rf obj dist

cleanall: clean npmclean elmclean

obj/app.js: objdir
	elm make --warn --yes --output obj/app.js src/app.elm

obj/app.min.js: npm obj/app.js
	${uglifyjs} < obj/app.js > obj/app.min.js

obj/app.html: objdir
	cp {src,obj}/app.html

obj/app.pack.html: obj/app.min.js obj/app.html
	scripts/include.awk < obj/app.html > obj/app.pack.html

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
