Generator = require './generator'

#g = new Generator("(abc|def)(ghi|jkl)", 'I am $1 or $2.')
#console.log g.filter " fg ", null

g = new Generator()
g.add "(abc|def)(ghi|jkl)", 'I am $1 or $2.'
f = (a, cmd) -> console.log "#{a} => #{cmd}"
g.filter " cn ", f, 2
