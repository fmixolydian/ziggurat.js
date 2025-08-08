let counter = new zg.mirror("counter", -20)
let todos = []

function addTodo(data) {
	todos.push(data.todo)
	zg.query('#todos').appendChild(
		zg.create('todo', data)
	)
}


async function startStreaming() {
	let stream = zg.query('#stream')
	stream.innerText = ""

	/*
	fetch("https://h.sqrt5.eu/chunked?delay=100")
		.then(async (response) => {
			let reader = response.body.getReader();
			let decoder = new TextDecoder();

			while (true) {
				let result = await reader.read();
				let data = decoder.decode(result.value)

				stream.innerText += data

				if (result.done) break;
			}
		})
	*/
	for await (let data of zg.stream.jsonl(
			'https://h.sqrt5.eu/chunked?delay=50&type=names&split=random')) {
		console.log(data)
		stream.appendChild(zg.create("person", data))
	}
}
