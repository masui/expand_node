# require 'assert'

Generator = require './generator'
Scanner = require './scanner'

class Re_Expand
  constructor: ->
    g = new Generator(123)
    s = new Scanner("a(bc|de)?fg")
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    s.ungettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()
    console.log s.gettoken()

  test: ->
    console.log "test"

module.exports = Re_Expand
