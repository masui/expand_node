Generator = require './generator'

g = new Generator()
g.add "a(b)*c", 'b is $1'
g.filter " b ", (s,cmd) ->
  console.log cmd
