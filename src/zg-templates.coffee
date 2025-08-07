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
