# re_expand

* Generates all text strings that match the given regexp

 * ```"(a|b)(1|2)".expand()``` => ```["a1", "a2", "b1", "b2"]```
* If a filter pattern is given, the output is filtered by the pattern.


## Resources

* [GitHub](https://github.com/masui/expand_node)
* [npmjs.org](https://npmjs.org/package/re_expand)

## Install

    $ npm install re_expand

## Usage

see sample/*.coffee.

```coffee
require 're_expand'

console.log "(a|b|c)(x|y|z)(1|2|3)".expand()
```


```coffee
Generator = require 're_expand'

generator = new Generator()
generator.add "(abc|def)(ghi|jkl)", 'Pattern "$1" and "$2".'
f = (a, cmd) -> console.log "#{a} => #{cmd}"
generator.filter " a ", f, 0

```
