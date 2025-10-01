TARGETS      := zg-core zg-forms zg-mirror zg-cookies zg-numeric zg-stream zg-templates
TARGET_FILES := $(foreach target, $(TARGETS), build/$(target).js)
   MIN_FILES := $(foreach target, $(TARGETS), build/$(target).min.js)

# DIST FILES

ziggurat: build/ziggurat.js

build/ziggurat.js: build/VERSION src/*.coffee	
	macc src/ziggurat.coffee -I src/ | coffee -scpb > $@

# MODULES

build/zg-%.js: build/VERSION src/zg-%.coffee
	coffee -bcp $< > $@

# GENERAL RULES

build/VERSION: package.json
	echo "zg.VERSION = `jq .version package.json`" > build/VERSION

clean:
	rm -rf build/* dist/*

run: ziggurat
	cp -vr test/* build/
	python3 -m http.server -d build

everything: $(TARGET_FILES) ziggurat

watch:
	./tools/watch
