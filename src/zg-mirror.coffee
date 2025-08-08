# TODO: mirror to cookie, or to local storage
# TODO: custom setter for zg.mirror

zg.mirror = class
	constructor: (@name, _value) ->
		Object.defineProperty @, "v",
			get: -> @_value
			set: (val) ->
				# when V is set, also update the bound valus in HTML
				@_value = val
				for bind in zg.queryall "zg-bind[name=#{@name}]"
					bind.innerText = @_value
		# also call the setter
		@v = _value
