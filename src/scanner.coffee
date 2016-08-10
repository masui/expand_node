# -*- coding: utf-8 -*-
#
# 文字列から1トークンずつ取得
# 
class Scanner
  constructor: (s) ->
    @s = s
    @a = s.split ''
    @p = 0
    @t = ''
    @u = ''

  gettoken: ->
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
      @p += 1
      @t = @a[@p]
      @t = "\n" if @t == 'n'
      @t = "\t" if @t == 't'
      @p += 1
      return @t
    else
      @p += 1
      while @p < @a.length && ! @a[@p].match /^[\(\|\)\*\+\?\[\]\\]$/
        @t += @a[@p]
        @p += 1
      return @t

  ungettoken: ->
    if @u == ''
      @u = @t
    else
      console.log "Can't ungettoken()"

  nexttoken: ->
    @t

module.exports = Scanner
