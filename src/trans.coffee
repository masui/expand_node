class Trans
  constructor: (@pat, @dest) ->  # pat にマッチしたら dest に遷移
    
  str: ->
    @pat.split(/\t/)[0]
    
  arg: ->
    m = @pat.match /^(.*)\t(.*)$/
    if m
      return m[2]
    else
      return @pat
  
module.exports = Trans
