TARGETS      := zg-core zg-forms zg-mirror
TARGET_FILES := $(foreach target, $(TARGETS), build/$(target).js)

# DIST FILES

ziggurat: build/ziggurat.js

build/ziggurat.js: $(TARGETS)
	cat $(TARGET_FILES) > build/ziggurat.js

# MODULES

zg-core: build/zg-core.js
zg-forms: build/zg-forms.js
zg-mirror: build/zg-mirror.js

build/zg-%.js: src/zg-%.coffee
	coffee -bcp $< > $@

# GENERAL RULES

clean:
	rm -rf build/* dist/*

run: ziggurat
	cp -vr test/* build/
	python3 -m http.server -d build

watch:
	./tools/watch
