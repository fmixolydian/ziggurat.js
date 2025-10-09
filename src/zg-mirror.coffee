zg.mirror = class
	constructor: (@name, _value, setters, options) ->
		Object.defineProperty @, "v",
			get: -> @_value
			set: (val) ->
				# when V is set, also update the bound valus in HTML
				@_value = val
				@update()
		
		# also call the setter
		@setters = setters or []
		@options = options
		@v = _value
	
	update: ->
		# call custom setters
		for setter in @setters
			setter @_value, @name, @options

zg.mirror_to_document = (value, name) ->
	# update BINDs
	for bind in zg.queryall "zg-bind[name=#{name}]"
		
		script = bind.getAttribute 'script'
		bind.innerText = if script? then zg.evalwith script, value else value
	
	# update WHENs 
	for toggle in zg.queryall "zg-when[name=#{name}]"
		show = false
		
		script = toggle.getAttribute 'script'
		if script? then show = zg.evalwith script, value

		toggle.hidden = not show

zg.mirror_to_localstorage = (value, name) ->
	localStorage[name] = value

zg.mirror_to_console = (value, name) ->
	console.debug "ziggurat: mirror #{name} = '#{value}'"
