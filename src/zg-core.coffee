# contains all core logic (templates) as well as query
# note: requires imperative HTML to work

if not HTML?
	throw new Error "can't find HTML. did you forget to import imperative-html?"

zg = {}

# functions

# query

zg.query = (selector) ->
	result = document.querySelectorAll selector
	if result.length is 1 then result[0] else result

zg.queryone = (selector) -> document.querySelector    selector
zg.queryall = (selector) -> document.querySelectorAll selector

# template creation

zg.create = (name, data) ->
	template = zg.query "zg-template#" + name
	if not template?
		throw new TypeError 'no such template with name ' + name
	
	processTemplateChildren = (div) ->

	processTemplateChildren template

zg.addStyle = (css) ->
	if not (zg.query "#zg-styles")
		head.appendChild (HTML.style {'id': 'zg-styles'})

# add rule for hiding <zg-template>
zg.addStyle 
