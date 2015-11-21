# 第二章
# 基本语法
run = ->
	"Hello, Coffescript!"
console.log run()
console.log do run
console.log (->"Hello, Coffescript!")() 
# 2.1 访问arguments 参数
greeting = -> "Hello, #{arguments[0]}!"
console.log greeting()
console.log greeting "Coffee"
# 条件表达式异常
# exp1
cube = (num) -> Math.pow num, 3
console.log cube 2
# exp2
odd = (num) -> num % 2 is 1
for i in [0...10]
	console.log "#{i} is odd : " + odd i
# 异常
# exp1
isInteger = (num) -> 
	unless typeof num is 'number'
		throw "The arguments of #{num} is not a Number"
	unless num is Math.round num
		throw "The argument of #{num} is not a Integer"
	true
console.log isInteger 5
console.log isInteger 32
# console.log isInteger "ccc"

# try catch
try
	console.log isInteger "ddd"
catch e
	# ...
	console.log "executing error : #{e}"

# 2.2 作用于
# 1. 每个函数都会创建一个作用域，且创建一个作用域的唯一方法就是定义一个函数
# 2. 一个变量存在于最外层的作用于中，在该作用域中，该变量会被赋值
# 3. 变量在作用域之外不可见
# exp1
singCountDown = (count) ->
	singBottleCount = (specifyLocation) ->
		locationStr = if specifyLocation then "on the wall" else ""
		bottleStr = if count is 1 then 'bottle' else 'bottles'
		console.log "#{count} #{bottleStr} of beer #{locationStr}"
	singDecrement = ->
		console.log "Take one down, pass it around"
		count--
	singBottleCount true
	singBottleCount	false
	do singDecrement
	singBottleCount true
	if count isnt 0 then singCountDown count
# singCountDown 2

# 2.3 上下文
# 1. 如果使用new关键字创建对象，则函数的上下文为新创建的这个对象
# 2. 如果使用call或apply方法，则上下文是第一个参数
# 3. 如果使用obj.func调用函数，则函数的上下文为obj
# 4. 其他情况下，上下文为全局
setName = (name) -> @name = name
cat = {}
cat.setName = setName
cat.setName "gordon"
console.log cat.name

# apply & call
pig = {}
setName.apply pig, ['zbj']
console.log pig.name
setName.call pig, "swk"
console.log pig.name

# 函数绑定 =>
# 绑定当前对象，
# 例子: 
# $('btn').click(function(e){
# 		var _this = this;
# 		$('userName').focus(function(e){
# 			this.text = _this.text
# 		})
# })
# 这里就是将_this绑定住
# 说明2

# this.clickHandler = -> alert "clicked"
# element.addEventListener "click", (e) => this.clickHandler(e) 
# element.addEventListener "click", (e) -> this.clickHandler(e) 
# this.clickHandler = function() {
# 	return alert("clicked");
# };
# exp 1. 
# element.addEventListener("click", (function(_this) {
#   return function(e) {
#     return _this.clickHandler(e);
#   };
# })(this));
# exp 2
# element.addEventListener("click", function(e) {
#   return this.clickHandler(e);
# });
# exp1的this代表外层的上下文，而exp2的this代表自己element

callback = (message) => @voiceMail.push message # 这里绑定了全局的voicemail为上下文
@voiceMail = []

big = {}
big.callback = callback
big.voiceMail = []
big.callback 'haha' # 就算这里使用big调用callback，big的voicemail都是空，而全局的voicemail在增加
console.log big.voiceMail
console.log @voiceMail

# 2.4 函数属性
setName = (name) -> @name = name
setName = (@name) ->

# 2.5 默认参数
isOk = (val = true) ->
	val
# a or= b a ?= b 区别
# a or= b 表示如果a为null或undefined 则将b赋值给a
# a ?= b表是a是否存在？ 例如可以obj?.say() 或 obj.say?()

console.log person?.say()
person =
	say:->
		"hello"
console.log person?.say()
console.log person.said?()

dontTryThisAtHome = (noArgNoProblem = @iHopeThisWorks()) ->

dontTryThisAtHome = (noArgNoProblem) ->
	noArgNoProblem ?= @iHopeThisWorks()

# 2.6 参数列

team = (caption, others...) ->
	console.log "The caption of Team is '#{caption}'"
	console.log "The others of Team are '#{others.join(', ')}'"


sss = [
	'a'
	'b'
	'c'
	'd'
]

scorce = (others..., first, last) ->
	console.log "The first of team is '#{first}'"
	console.log "The others of team are '#{others.join(", ")}'"
	console.log "The last one is '#{last}'"

obj = {}
scorce.apply(null, sss)

[first, others...] = sss
console.log first
console.log others.join ', '

console.log sss, 4
console.log sss..., 4
array = [sss..., 4]

# 联系
run = (func, data...) -> func.apply this, data...


# 第三章
# 3.1 json
obj = new Object()
obj = {}

# obj.+ = 'plus'
obj['+'] = 'plus'
elementName = 'name'
obj[elementName] = 'plus'

father = 
	name : 'John',
	daughter :
		name : 'Jill'
	son :
		name : 'Jack'

symbols =
	'+' : 'plus'
	'-' : 'minus'
# 3.1.2 精简json
father = 
	name : 'John'
	age : 32
	daughter : 
		name : 'lili'
		age : 17

gordon = name:'gordon',age:30, addr : {post:200000, road:'halei'}

# 3.1.3 同名键值对
name = "gordon"
person = {
	name
}

# 3.1.4 吸收操作符
# a = b.proerty ? c
# a = b?.proerty ? c

cats?['Tom']?.eat?() if fish?

# 3.2 数组
teamer = ['gordon', 'messi', 'xavi', 'pique', 'puyol']
console.log teamer[0]
console.log teamer['0']
console.log teamer[do ->"0"]
console.log teamer[{toString:->"0"}]

# 3.2.1 区间
console.log [1..5]
console.log [1...5]
console.log [5..1]

# 3.2.2 切分
console.log teamer.slice 0, 3
console.log teamer[0..3]
console.log teamer[0...3]

console.log teamer[1..]
console.log teamer[1...]


# 3.3 迭代
# for ... of object
# for ... in array by 2

for key, val of father when typeof val isnt 'object'
	console.log key + ' - ' + val

# own 是 obj.hasOwnProperty(...) 的简写
# for own val of object

for val in [0..10] by 2
	console.log val

for val in [0.1...1.0] by 0.1
	console.log val

# exist = 'a'
isOk = true if exist?
isOk = false unless exist?
isOk ?= exist

console.log isOk

array1 = ['a', 'b', 'c', 'd']
console.log array1
console.log array1...
console.log array1.join(', ')

array2 = [array1, 'f']
console.log array2


do -> console.log 'closure'
do (i) -> console.log 'closure'
=> console.log 'closure this'


tt = {}
((@name) -> ).call(tt, 'jim')
console.log tt.name