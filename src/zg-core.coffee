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

# template creation

zg.create = (name, data) ->
	template = zg.queryone "zg-template#" + name
	if not template?
		throw new TypeError 'no such template with name ' + name
	
	build = (div, data) ->

		elements = div.cloneNode true
		new_elements = []

		# does the element have children?
		if elements.children?
			# compile every child
			for child in elements.children
				# depending on tag, replace with something
				if child.tagName?
					switch (child.tagName.toLowerCase())
						when "zg-var"
							child = document.createTextNode zg.deepfind data, child.innerHTML

				# if the child has children, build the child
				if child.children?
					child.replaceChildren (build child, data)...
				new_elements.push child
		else
			new_elements = elements.childNodes
		new_elements

	HTML.div build template, data
