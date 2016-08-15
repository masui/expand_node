Generator = require './generator'

g = new Generator("(abc|def)jjjj")
g.generate " b ", ((s) -> console.log "<<<<<#{s}>>>>>"), 0
