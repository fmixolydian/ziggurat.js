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
				text.replace /\\?\$\{(.+?)\}/g, (match, script) ->
					if match.startsWith '\\' then match else zg.evalwith script, data
			
			# depending on tag, replace with something
			switch (element.nodeName.toLowerCase())
				when "zg-if"
					unless (zg.evalwith (element.getAttribute "zg-script"), data)
						element = document.createTextNode ""

			if element.nodeName is '#text'
				element.data = replace_vars element.data

			else
				for i in [0 ... element.attributes.length]
					element.attributes[i] = replace_vars element.attributes[i].value 

			# if the child has more children, build the child
			if element.children?
				element.replaceChildren (build element, data)...
			
			new_elements.push element
		new_elements

	HTML.div build template, data
