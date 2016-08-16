Generator = require './generator'

g = new Generator("a(b)*c")
g.generate " b ", ((s) -> console.log "#{s}"), 0
