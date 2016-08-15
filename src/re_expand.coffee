# require 'assert'

Generator = require './generator'
Scanner = require './scanner'
Node = require './node'

class Re_Expand
  constructor: ->
    #g = new Generator(123)
    #s = new Scanner("a(bc|de)?fg")
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #s.ungettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()
    #console.log s.gettoken()

    node1 = new Node()
    node2 = new Node()
    node3 = new Node()
    console.log Node.nodes()

  test: ->
    console.log "test"

module.exports = Re_Expand
