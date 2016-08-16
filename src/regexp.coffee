Node = require './node'
Scanner = require './scanner'

class RegExp
  #
  # 正規表現をパースして状態遷移機械を作る
  #
  #            n1     n2
  #        +-->□.....□--+
  # start /                \  end
  #     □ --->□.....□---> □
  #       \                /
  #        +-->□.....□--+
  #

  #          ( (  )  )  ( (    ) (  (  )  ) (   )  )  | (  (  )  )
  #  pars   [1]     
  #           [1,2]
  #                    [3]
  #                     [3,4]
  #                             [3,5]

  regexp: (s, toplevel=false) -> # regcat { '|' regcat }
    startnode = new Node()
    endnode = new Node()
    
    if toplevel
      @pars = []
      @parno = 0
      @ruleid = 0

    startnode.pars = @pars
    endnode.pars = @pars

    [n1, n2] = @regcat(s)

    startnode.addTrans '', n1
    if toplevel
      n2.accept = @ruleid
    n2.addTrans '', endnode

    while s.gettoken() == '|' && s.nexttoken() != ''
      if toplevel
        @pars = []
        @parno = 0
        @ruleid += 1
      [n1, n2] = @regcat(s)
      startnode.addTrans '', n1
      if toplevel
        n2.accept = @ruleid
      n2.addTrans '', endnode

    s.ungettoken()
    [startnode, endnode]

  regcat: (s) -> # regfactor { regfactor }
    [startnode, endnode] = @regfactor s
    while !s.gettoken().match(/^[\)\]\|]$/) && s.nexttoken() != ''
      s.ungettoken()
      [n1, n2] = @regfactor s
      endnode.addTrans '', n1
      endnode = n2
    s.ungettoken()
    [startnode, endnode]

  regfactor: (s) -> # regterm [ '?' | '+' | '*' ]
    [startnode, endnode] = @regterm s
    t = s.gettoken()
    if t.match /^[\?]$/
      startnode.addTrans '', endnode
    else if t.match /^[\+]$/
      endnode.addTrans '', startnode
    else if t.match /^[\*]$/
      n = new Node()
      startnode.addTrans '', endnode
      endnode.addTrans '', n
      n.addTrans '', startnode
      # ループがあるとマズいのか? 上のように修正すると動くようなのだが
      #startnode.addTrans('',endnode)
      #endnode.addTrans('',startnode)
    else
      s.ungettoken()
    [startnode, endnode]

  regterm: (s) -># '(' regexp ')' | token
    t = s.gettoken()
    if t == '('
      @parno += 1
      @pars.push @parno
      [n1, n2] = @regexp(s)
      n1.pars = @pars.slice(0) # dup
      t = s.gettoken()
      if t == ')'
        @pars.pop()
        n2.pars = @pars.slice(0)
        return [n1, n2]
      else
        console.log 'missing )'
        return null 
    else
      startnode = new Node()
      startnode.pars = @pars.slice(0)
      endnode = new Node()
      endnode.pars = @pars.slice(0)
      startnode.addTrans t, endnode
      return [startnode, endnode]

module.exports = RegExp
