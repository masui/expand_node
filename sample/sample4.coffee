Generator = require 're_expand'

generator = new Generator()

generator.add "a(b)*c"

f = (a, cmd) -> console.log "#{a} => #{cmd}"

generator.filter " a ", f, 0
