let counter = new zg.mirror("counter", -20)
let todos = []

function addTodo(data) {
	todos.push(data.todo)
	zg.query('#todos').appendChild(
		zg.create('todo', data)
	)
}
