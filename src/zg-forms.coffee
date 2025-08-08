
zg.formdata = (element) ->
	data = {}

	# for each entry in the form,
	# add a reference to it in data
	(new FormData element).forEach (_, k) ->
		Object.defineProperty data, k,
			get:     -> element[k].value
			set: (v) -> element[k].value = v
	
	data

for element in zg.queryall('form[zg-submit]')
	fn_name = element.getAttribute "zg-submit"
	element.onsubmit = (event) ->
		
		# fuck around and find out
		try window[fn_name] zg.formdata element
		catch e
			console.error e
		
		# prevent event default
		event.preventDefault
		false
