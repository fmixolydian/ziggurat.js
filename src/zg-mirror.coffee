zg.mirror = class
	constructor: (@name, value, setters, options) ->
		if zg.MIRROR_INDEX[@name]?
			throw "can't create mirror #{@name}; it already exists"
		
		console.log "making mirror #{@name}"
		zg.MIRROR_INDEX[@name] = this
		Object.defineProperty @, "v",
			get: -> @_value_
			set: (val) ->
				# when V is set, also update the bound value in HTML
				@_value_ = val
				@update()
		
		# also call the setter
		@setters = setters or []
		@options = options
		if value? then @v = value
	
	update: ->
		# call custom setters
		for setter in @setters
			setter @_value_, @name, @options

zg.mirror_to_document = (value, name) ->
	# update BINDs
	for bind in zg.queryall "*[zg-bind-to=#{name}], *[zg-sync-with=#{name}]"
		script = bind.getAttribute "zg-script"
		result = if script? then zg.evalwith script, value else value
		if bind.nodeName is "INPUT"
			bind.value = result
		else
			bind.innerText = result
	
	# update WHENs 
	for toggle in zg.queryall "zg-when[zg-mirror=#{name}]"
		show = false
		
		script = toggle.getAttribute 'zg-script'
		if script? then show = zg.evalwith script, value

		toggle.hidden = not show

zg.mirror_to_localstorage = (value, name) ->
	localStorage[name] = value

zg.mirror_to_console = (value, name) ->
	console.debug "ziggurat: mirror #{name} = #{value}"

zg.MIRROR_INDEX = {}
zg._INIT_LIST.push ->
	handle_syncs = ->
		mirror = zg.MIRROR_INDEX[this.getAttribute 'zg-sync-with']
		mirror.v = this.value # trigger setters (hopefully dont cause an endlessly recursive loop of event handlers)
	
	for element in zg.queryall "*[zg-sync-with]"
		mirror_name = this.getAttribute 'zg-sync-with'
		mirror = zg.MIRROR_INDEX[mirror_name]
		throw "mirror #{mirror_name} doesn't exist!" unless mirror?

		element.addEventListener "oninput",  handle_syncs
		element.addEventListener "onchange", handle_syncs
