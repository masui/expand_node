Generator = require './generator'

g = new Generator()

g.add "(abc|def)(ghi|jkl)", 'I am $1 or $2.'
f = (a, cmd) -> alert "#{a} => #{cmd}"
g.filter " cg ", f, 0

$(document).on 'click', (e) -> alert('100')
