# 画正方形
square = (x) ->
	unless typeof x is 'number'
		throw "#{x} is not a number"
	unless x is Math.round x
		throw "#{x} is not a integer"
	line = ''
	for i in [0...x]
		line = ''
		for j in [0...x]
			line += '*'
		console.log line
square 10