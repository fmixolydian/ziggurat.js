# template creation

zg.create = (name, data) ->
	template = zg.queryone "zg-template#" + name
	if not template?
		throw new TypeError 'no such template with name ' + name
	
	build = (div, data) ->

		elements = div.cloneNode true
		new_elements = []

		# compile every child
		for element in elements.childNodes

			replace_vars = (text) ->
				text.replace /\\?\$\{(.+?)\}/g, (match, path) ->
					if match.startsWith '\\' then match else (zg.deepfind data, path) 
			
			# depending on tag, replace with something
			# FIXME: DEPRECATED
			switch (element.nodeName.toLowerCase())
				when "zg-var"
					element = document.createTextNode zg.deepfind data, element.innerHTML

			if element.nodeName is '#text'
				element.data = replace_vars element.data
			else
				for attr_key in element.attributes
					element.attributes[attr_key] = replace_vars element.attributes[attr_key]
				element.innerText = replace_vars element.innerText

			# if the child has more children, build the child
			if element.children?
				element.replaceChildren (build element, data)...
			new_elements.push element
		new_elements

	HTML.div build template, data
