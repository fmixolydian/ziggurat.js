zg.cookies = new Proxy {},
	get: (_, name) ->
		# extract cookie from document.cookie
		cookies = (cookie.split '=' for cookie in document.cookie.split '; ')
		for cookie in cookies
			if cookie[0] == name
				return cookie[1]
	set: (_, name, value) ->
		# build a statement to be put into document.cookie
		
		if typeof value == 'object'
			cookie = "#{name}=#{value.value}; "
			# add every property to cookie string
			cookie += ((if v? then "#{k} = #{v}" else "#{k}") for k, v of value if k isnt 'value').join '; '
		else
			cookie = "#{name}=#{value}"
		
		document.cookie = cookie

zg.load_json_cookie = (name) ->
	val = zg.cookies[name]
	try JSON.parse(val)
	catch SyntaxError
		null

zg.mirror_to_cookie = (value, name, options) ->
	zg.cookies[name] = {"value": JSON.stringify(value), options...}
