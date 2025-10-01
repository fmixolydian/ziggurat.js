Number::nanos   = -> this.micros() / 1000
Number::micros  = -> this.millis() / 1000
Number::millis  = -> this.seconds() / 1000
Number::seconds = -> this
Number::minutes = -> this.seconds() * 60
Number::hours   = -> this.minutes() * 60
Number::days    = -> this.hours()   * 24
Number::months  = -> this.days()    * 30.43684914
Number::years   = -> this.months()  * 12
Number::ago     = -> new Date(Date.now() - this*1000)
Number::fromnow = -> new Date(Date.now() + this*1000)

create_math_function = (name) ->
	-> this Math[name]

for key in Object.getOwnPropertyNames Math
	fun = Math[key]
	if fun.length == 1 and typeof fun is "function"
		eval "Number.prototype.#{key} = function() {return Math.#{key}(this)}"
