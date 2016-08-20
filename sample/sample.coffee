Generator = require '../'

g = new Generator()

g.add "(abc|def)(ghi|jkl)", 'Pattern "$1" and "$2".'
f = (a, cmd) -> console.log "#{a} => #{cmd}"
g.filter " c g ", f, 0

