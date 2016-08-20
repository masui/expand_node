Generator = require './generator'

generator = new Generator()

# g.add "(abc|def)(ghi|jkl)", 'I am $1 or $2.'
# f = (a, cmd) -> alert "#{a} => #{cmd}"
# g.filter " cg ", f, 0
# 
# $(document).on 'click', (e) -> alert('100')

schools = "(幼稚園|小学生|中学生|高校生)"
time = "(昔|子供のころ|#{schools}のころ)"
freq = "(よく行ってた|行ったことがある|たまに行った)"
shops = "(本屋|床屋|散髪屋)"

generator.add "#{time}(足|額)を怪我した(場所|町)"
generator.add "#{schools}のころ学校でよく暴れてた奴"
generator.add "#{time}#{freq}#{shops}"

f = (s, cmd) -> alert s

generator.filter " ", f, 0


