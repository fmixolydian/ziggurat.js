let counter = new zg.mirror("counter", 20, [
	zg.mirror_to_cookie,
	zg.mirror_to_localstorage,
	zg.mirror_to_document,
	zg.mirror_to_console
])

let todos = []
let ajax_results = new zg.multimirror("ajax_results", "person");

function addTodo(data) {
	todos.push(data.todo)
	zg.query('#todos').appendChild(
		zg.create('todo', data)
	)
}

async function startStreaming() {
	ajax_results.clear();
	try {
		for await (let data of zg.stream.jsonl(
				'https://h.sqrt5.eu/chunked?delay=50&type=names&split=random')) {
			ajax_results.push(data);
		}
	} catch {
		zg.queryone('zg-multibind[name=ajax_results]').appendChild(HTML.p("Unable to connect to Halifax", {"style": "color: red; font-weight: bold"}))
	}
}

zg.init();
