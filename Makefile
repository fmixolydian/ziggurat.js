ziggurat: zg-core zg-forms zg-mirror

zg-core: build/zg-core.js
zg-forms: build/zg-forms.js
zg-mirror: build/zg-mirror.js

# build/%.js: src/%/*.coffee
#	find $(dir $<) | grep ".coffee$$" | xargs cat | coffee -bco build -s > $@

build/zg-%.js: src/zg-%.coffee
	coffee -bcp $< > $@

clean:
	rm -rf build/*

run: ziggurat
	cp -vr test/* build/
	python3 -m http.server -d build

watch:
	./tools/watch
