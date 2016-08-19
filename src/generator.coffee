#          ( (  )  )  ( (    ) (  (  )  ) (   )  )  | (  (  )  )
#  pars   [1]     
#           [1,2]
#                    [3]
#                     [3,4]
#                             [3,5]

Scanner = require './scanner'
RegExp = require './regexp'
Node = require './node'
Asearch = require 'asearch'

class GenNode
  constructor: (@id, @state=[], @s="", @substrings=[], @accept=false) ->
  
class Generator
  constructor: (s = '', command = '') ->
    @s = [s]
    @commands = [command]
    @par = 0

  add: (pat,command) ->
    if @s[0] == '' then @s = [pat] else @s.push pat
    if @commands[0] == '' then @commands = [command] else @commands.push command

  delete: ->
    @s.pop
    @commands.pop

  #
  # ルールを解析して状態遷移機械を作成し、patにマッチするもののリストを返す
  #
  filter: (pat, func = null, @maxambig = 2) ->
    res = [[],[],[]] # 曖昧度0,1,2のマッチ結果
    patterns = pat.split('').map (p) ->
      p.toLowerCase()

    @asearch = new Asearch(pat)
    @regexp = new RegExp()
    @scanner = new Scanner(@s.join('|'))

    # HelpDataで指定した状態遷移機械全体を生成
    # (少し時間がかかる)

    [startnode, endnode] = @regexp.regexp(@scanner,true) # top level

    #
    # 状態遷移機械からDepth-Firstで文字列を生成する
    # n個のノードを経由して生成される状態の集合をlists[n]に入れる
    # 生成しながらマッチングも計算する
    #
    lists = []
    listed = [{},{},{}]
    func_listed = {}
    #
    # 初期状態
    #
    list = []
    list[0] = new GenNode(startnode.id, @asearch.state()) # initstate
    lists[0] = list

    for length in [0..10000]
      list = lists[length]
      newlist = []
      for entry in list
        srcnode = Node.node(entry.id)
        if list.length * srcnode.trans.length < 100000
          for trans in srcnode.trans
            ss = entry.substrings.slice(0) # dup
            for i in srcnode.pars
              ss[i-1] = '' if typeof(ss[i-1]) == "undefined"
              ss[i-1] = ss[i-1] + trans.arg()
            newstate = @asearch.state(entry.state, trans.str()) # 新しいマッチング状態を計算してノードに保存
            s = entry.s + trans.str()
            acceptno = trans.dest.accept
            newlist.push new GenNode(trans.dest.id, newstate, s, ss, acceptno)
            #
            # この時点で、マッチしているかどうかをstateとacceptpatで判断できる
            # マッチしてたら出力リストに加えるかfuncを呼び出す
            #
            if acceptno != null
              for ambig in [0..@maxambig]
                if (func && !func_listed[s]) or (!func && !listed[ambig][s])
                  if (newstate[ambig] & @asearch.acceptpat) != 0
                    listed[ambig][s] = true
                    func_listed[s] = true
                    sslen = ss.length
                    match = []
                    if sslen > 0
                      patstr = []
                      patstr.push '(.*)' for i in [0...sslen]
                      patstr = patstr.join "\t"
                      match = ss.join("\t").match(patstr)
                    command = @commands[acceptno]
                    while m = command.match /^(.*)(\$(\d+))(.*)$/
                      command = "#{m[1]}#{match[m[3]]}#{m[4]}"
                    if func
                      func s, command
                    else
                      res[ambig].push [s, command]

      break if newlist.length == 0
      lists.push newlist
      break if res[0].length > 100

    [res[0], res[1], res[2]]

module.exports = Generator

