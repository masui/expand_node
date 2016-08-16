Generator = require './generator'

g = new Generator("(abc|def)(ghi|jkl)", 'I am $1 or $2.')
console.log g.filter " b ", null, 0

# g = new Generator()
# g.add "(abc|def)(ghi|jkl)", 'I am $1 or $2.'
# g.filter " b ", (a, cmd) -> console.log "#{a} => #{cmd}"
