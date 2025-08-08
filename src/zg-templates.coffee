# template creation

zg.create = (name, data) ->
	template = zg.queryone "zg-template#" + name
	if not template?
		throw new TypeError 'no such template with name ' + name
	
	build = (div, data) ->

		elements = div.cloneNode true
		new_elements = []

		# compile every child
		for child in elements.childNodes
			# depending on tag, replace with something
			switch (child.nodeName.toLowerCase())
				when "zg-var"
					child = document.createTextNode zg.deepfind data, child.innerHTML

			# if the child has more children, build the child
			if child.children?
				child.replaceChildren (build child, data)...
			new_elements.push child
		new_elements

	HTML.div build template, data
