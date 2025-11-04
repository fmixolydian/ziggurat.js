zg.multimirror = class
	push: (data) ->
		@v.push data
	
		# update ZG-MULTIBINDs
		for bind in zg.queryall "zg-multibind[name=#{@name}]"
			bind.appendChild zg.create @template, data
		
		data
	
	insert: (element, index) ->
		@v.splice index, 0, element
		if index is -1 then @push element

		for bind in zg.queryall "zg-multibind[name=#{@name}]"
			bind.appendBefore (bind.children[index]), zg.create @template, element

		element
	
	delete: (index) ->
		# remove Nth child
		if index < 0 then (@v.length - -index) else index

		if index < @v.length
			@v.splice index, 1
			for bind in zg.queryall "zg-multibind[name=#{@name}]"
				bind.removeChild bind.children[index]

	clear: ->
		@v = []
		for bind in zg.queryall "zg-multibind[name=#{@name}]"
			bind.innerHTML = ""

	pop: ->
		delete -1

	constructor: (@name, @template, _value) ->
		@v = []
		if _value? then @push e for e in _value
