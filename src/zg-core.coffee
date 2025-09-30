# contains all core logic (templates) as well as query
# note: requires imperative HTML to work

if not HTML?
	throw new Error "can't find HTML. did you forget to import imperative-html?"


zg = {}

# functions

# query

zg.query = (selector) ->
	result = document.querySelectorAll selector
	if result.length is 1 then result[0] else result

zg.queryone = (selector) -> document.querySelector    selector
zg.queryall = (selector) -> document.querySelectorAll selector

# misc

zg.deepfind = (data, path) ->
	path = path.trim()
	for index in (node for node in (path.split '.') when node isnt "")
		data = data[index]
		if not data?
			throw new Error "'#{path}' not in data '#{data}'"
	data

zg._INIT_LIST = []

zg.init = ->
	f() for f in zg._INIT_LIST
