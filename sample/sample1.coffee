Generator = require 're_expand'

generator = new Generator()

generator.add "(abc|def)(ghi|jkl)", 'Pattern "$1" and "$2".'

f = (a, cmd) -> console.log "#{a} => #{cmd}"

generator.filter " a ", f, 0
