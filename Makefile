TARGETS      := zg-core zg-forms zg-mirror zg-cookies zg-numeric zg-stream zg-templates
TARGET_FILES := $(foreach target, $(TARGETS), build/$(target).js)
   MIN_FILES := $(foreach target, $(TARGETS), build/$(target).min.js)

# DIST FILES

ziggurat: build/ziggurat.js
ziggurat-min: build/ziggurat.min.js

build/ziggurat.js:
	macc src/ziggurat.coffee -I src/ | coffee -scp > build/ziggurat.js

build/ziggurat.min.js: build/ziggurat.js
	minify build/ziggurat.js > build/ziggurat.min.js

# MODULES

build/zg-%.js: src/zg-%.coffee
	coffee -bcp $< > $@

build/%.min.js: build/%.js
	minify $< -o $@
	echo >> $@

# GENERAL RULES

clean:
	rm -rf build/* dist/*

run: ziggurat
	cp -vr test/* build/
	python3 -m http.server -d build

everything: ziggurat ziggurat-min $(TARGET_FILES) $(MIN_FILES)

watch:
	./tools/watch
