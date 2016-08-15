#
#  ノードとノード間遷移
#
#  (self)  pat     dest
#    ■ ----------> □
#       ----------> □
#       ----------> □
#

__ = require 'underscore-node'
Trans = require './trans'

class Node
  @id = 1
  @_nodes = {}
    
  constructor: ->
    #console.log "Node generated id=#{Node.id}"
    @id = Node.id # Node.idはクラス変数で@idはインスタンス変数
    @accept = null
    @trans = []
    Node._nodes[Node.id++] = this
    @pars = []
    
  addTrans: (pat,dest) ->
    t = new Trans(pat,dest)
    @trans.push t
    
  @node: (id) -> # ノードidからノードを取得
    #console.log "Access Node.node(#{id})"
    Node._nodes[id]
    
  @nodes: ->
    __.values Node._nodes

module.exports = Node
