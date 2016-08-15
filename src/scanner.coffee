#
# 文字列から1トークンずつ取得
#
#  Scanner = require 'scanner'
#  s = new Scanner("a(bc|de)?fg")
#  console.log s.gettoken() => 'a'
#  console.log s.gettoken() => '('
#  console.log s.gettoken() => 'bc'
#  ...
#

class Scanner
  constructor: (s) ->
    @s = s
    @a = s.split ''
    @p = 0
    @t = ''
    @u = ''

  gettoken: ->
    token = @gettoken__()
    #console.log "GETTOKEN token = #{token}"
    token

  gettoken__: ->
    if @u != ''
      @t = @u
      @u = ''
      return @t
    if @p >= @a.length
      @t = ''
      return ''
    @t = @a[@p]
    if @t.match /^[\(\|\)\*\+\?\[\]]$/
      @p += 1
      return @t
    else if @t == '\\'
      @t = @a[++@p]
      @t = "\n" if @t == 'n'
      @t = "\t" if @t == 't'
      @p += 1
      return @t
    else
      @p += 1
      while @p < @a.length && ! @a[@p].match /^[\(\|\)\*\+\?\[\]\\]$/
        @t += @a[@p++]
      return @t

  ungettoken: ->
    if @u == ''
      @u = @t
    else
      console.log "Can't ungettoken()"

  nexttoken: ->
    @t

module.exports = Scanner
