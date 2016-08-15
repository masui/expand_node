Generator = require './generator'

g = new Generator("(abc|def)jjjj")
console.log g.generate " b ", ((s) -> console.log "<<<<<#{s}>>>>>kkkkkk"), 0
