#
#  ノードとノード間遷移
#
#  (self)  pat     dest
#    ■ ----------> □
#       ----------> □
#       ----------> □
#

__ = require 'underscore-node'

#Trans = require './trans'

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

class Node
  @id = 1
  @nodes = {}
    
  constructor: ->
    @id = Node.id # Node.idはクラス変数で@idはインスタンス変数
    @accept = null
    @trans = []
    Node.nodes[Node.id++] = this
    @pars = []
    
  addTrans: (pat,dest) ->
    t = new Trans(pat,dest)
    @trans.push t
    
  @node: (id) -> # ノードidからノードを取得
    Node.nodes[id]
    
module.exports = Node
