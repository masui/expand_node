# re_expand

* Generates all the text strings that match the given regexp.

    `"(a|b)(1|2)"` => `["a1", "a2", "b1", "b2"]`

* If a filter pattern is given, the output is filtered by the pattern.

### Install

    $ npm install re_expand

### Usage

see sample/sample.coffee

```coffee
Generator = require 're_expand'

g = new Generator()

g.add "(abc|def)(ghi|jkl)", 'Pattern "$1" and "$2".'
f = (a, cmd) -> console.log "#{a} => #{cmd}"
g.filter " c g ", f, 0
```
