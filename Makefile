include config.mk

default: build

.PHONY: clean npmclean elmclean npm

build: obj/main.pack.html

dist: test distdir obj/main.pack.html
	cp obj/main.pack.html dist/index.html

debug: obj/main.debug.pack.html

test: obj/main-test.pack.js
	node obj/main-test.pack.js

clean:
	rm -rf obj dist

cleanall: clean npmclean elmclean

obj/main.js: objdir src/*.elm
	elm make --warn --yes --output obj/main.js src/main.elm

obj/main.min.js: npm obj/main.js
	${compressjs} < obj/main.js > obj/main.min.js

obj/boot.js: objdir src/boot.js
	cp {src,obj}/boot.js

obj/boot.min.js: npm obj/boot.js
	${compressjs} < obj/boot.js > obj/boot.min.js

obj/main.html: objdir src/main.html
	cp {src,obj}/main.html

obj/main.pack.html: obj/main.min.js obj/boot.min.js obj/main.html
	./scripts/pack-html.awk -v minimized=true < obj/main.html > obj/main.pack.html

obj/main.debug.pack.html: obj/main.js obj/boot.js obj/main.html obj/test-interop.js
	./scripts/pack-html.awk < obj/main.html > obj/main.debug.pack.html

obj/test-interop.js: objdir src/test-interop.js
	cp {src,obj}/test-interop.js

obj/test-imports.elm: objdir src/*.elm
	ls src/*Test.elm | scripts/gen-test.awk -v type=imports > obj/test-imports.elm

obj/test-cases.elm: objdir src/*.elm
	ls src/*Test.elm | scripts/gen-test.awk -v type=cases > obj/test-cases.elm

obj/main-test.elm: obj/test-imports.elm obj/test-cases.elm
	scripts/pack-test.awk < src/main-test.elm > obj/main-test.elm

obj/main-test.js: obj/main-test.elm
	elm make --warn --yes --output obj/main-test.js obj/main-test.elm

obj/main-test.pack.js: obj/main-test.js src/boot-test.js
	cat obj/main-test.js src/boot-test.js > obj/main-test.pack.js

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
