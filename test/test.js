function addTodo(data) {
	zg.query('#todos').appendChild(
		zg.create('todo', data)
	)
}
