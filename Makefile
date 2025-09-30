TARGETS      := zg-core zg-time zg-forms zg-mirror zg-cookies zg-numeric
TARGET_FILES := $(foreach target, $(TARGETS), build/$(target).js)
   MIN_FILES := $(foreach target, $(TARGETS), build/$(target).min.js)

# DIST FILES

ziggurat: build/ziggurat.js
ziggurat-min: build/ziggurat.min.js

build/ziggurat.js: $(TARGET_FILES)
	cat $(TARGET_FILES) > build/ziggurat.js

build/ziggurat.min.js: $(MIN_FILES)
	cat $(MIN_FILES)    > build/ziggurat.min.js

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

everything: ziggurat ziggurat-min

watch:
	./tools/watch
