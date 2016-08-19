Generator = require './generator'

#g = new Generator("a(b)*c", 'kkk is $1')
#console.log g.filter " b "

g = new Generator()
g.add "a(b)*c", 'b is $1'
console.log g.filter " b ", null
