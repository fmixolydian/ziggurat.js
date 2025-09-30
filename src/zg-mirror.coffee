zg.mirror = class
	constructor: (@name, _value, setters, options) ->
		Object.defineProperty @, "v",
			get: -> @_value
			set: (val) ->
				# when V is set, also update the bound valus in HTML
				@_value = val
				
				# update DOM
				for bind in zg.queryall "zg-bind[name=#{@name}]"
					bind.innerText = @_value
				
				# call custom setters
				for setter in setters
					setter @_value, @name, options
		
		# also call the setter
		@v = _value

zg.mirror_to_localstorage = (value, name, options) ->
	localStorage[name] = value
