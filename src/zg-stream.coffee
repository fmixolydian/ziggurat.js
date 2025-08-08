
zg.stream = {}

class zg.HttpException extends Error
	constructor: (status) ->
		super "Recieved code #{status} from server"
		@status = status

# chunked fetch
# yields all data available
zg.stream.text = (url, options) ->
	res = await fetch url, options
	if not res.ok
		throw new zg.HttpException res.statusCode
	reader = res.body.getReader()
	decoder = new TextDecoder()
	loop
		result = await reader.read()
		data = decoder.decode result.value
		if data.length > 0 then yield data
		if result.done then return

# yields all lines as raw text
zg.stream.lines = (url, options) ->
	buffer = ""
	for await data from zg.stream.text url, options
		buffer += data
		lines = buffer.split "\n"
		if lines.length > 1
			yield lines[0]
			lines = lines[1..]
			buffer = lines.join "\n"
	for line in lines
		if line.length > 0 then yield line

# yields all lines as JSON
zg.stream.jsonl = (url, options) ->
	for await line from zg.stream.lines url, options
		yield try JSON.parse line
