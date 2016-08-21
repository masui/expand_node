Generator = require 're_expand'

g = new Generator()

g.add "(abc|def)(ghi|jkl)", 'Pattern "$1" and "$2".'

f = (a, cmd) -> console.log "#{a} => #{cmd}"

g.filter " a ", f, 0
