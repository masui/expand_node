#          ( (  )  )  ( (    ) (  (  )  ) (   )  )  | (  (  )  )
#  pars   [1]     
#           [1,2]
#                    [3]
#                     [3,4]
#                             [3,5]

Scanner = require './scanner'
RegExp = require './regexp'
Node = require './node'
Trans = require './trans'
Asearch = require 'asearch'

class GenNode
  constructor: (@id, @state=[], @s="", @substrings=[], @accept=false) ->
  

class Generator
  constructor: (s = nil) ->
    @s = if s then  [s] else []
    @matchedlist = []
    @par = 0
    @commands = []

  add: (pat,command) ->
    @s.push pat
    @commands.push command

  delete: ->
    @s.pop
    @commands.pop

  #
  # ルールを解析して状態遷移機械を作成し、patにマッチするもののリストを返す
  #
  generate: (pat, blockambig=0) ->
    res = [[],[],[]] # 曖昧度0,1,2のマッチ結果
    patterns = pat.split('').map (p) ->
      p.toLowerCase()

    @asearch = new Asearch(pat)
    @regexp = new RegExp()
    @scanner = new Scanner(@s.join('|'))

    # HelpDataで指定した状態遷移機械全体を生成
    # (少し時間がかかる)
    console.log @scanner
    console.log "-----"
    [startnode, endnode] = @regexp.regexp(@scanner,true) # top level

    #
    # 状態遷移機械からDepth-Firstで文字列を生成する
    # n個のノードを経由して生成される状態の集合をlists[n]に入れる
    # 生成しながらマッチングも計算する
    #
    lists = []
    listed = [{},{},{}]
    block_listed = {}
    #
    # 初期状態
    #
    list = []
    console.log "statrnode.id = #{startnode.id}"
    list[0] = new GenNode(startnode.id, @asearch.state()) # initstate
    lists[0] = list

    for length in [0..10000]
      console.log "----------------length=#{length}"
      list = lists[length]
      console.log "list=#{list}"
      console.log "list.length = #{list.length}"
      newlist = []
      for entry in list
        console.log "length=#{length}, entry.id=#{entry.id}"
        srcnode = Node.node(entry.id)
        console.log "srcnode = #{srcnode}"
        console.log "srcnode.trans.length = #{srcnode.trans.length}"
        if list.length * srcnode.trans.length < 100000
          console.log "srcnode.trans = #{srcnode.trans}"
          for trans in srcnode.trans
            console.log "trans = #{trans}"
            console.log "entry.substrings = #{entry.substrings}"
            ss = entry.substrings.slice(0) # dup
            console.log "ss = #{ss}"
            for i in srcnode.pars
              ss[i-1] = ss[i-1] + trans.arg()
            newstate = @asearch.state(entry.state, trans.str()) # 新しいマッチング状態を計算してノードに保存
            console.log "newstate = #{newstate} trans.str = #{trans.str()}"
            s = entry.s + trans.str()
            acceptno = trans.dest.accept
            console.log "acceptno = #{acceptno}"
            newlist.push new GenNode(trans.dest.id, newstate, s, ss, acceptno)
            #
            # この時点で、マッチしているかどうかをstateとacceptpatで判断できる
            # マッチしてたら出力リストに加える
            #
            if acceptno != false
#                if block_given? then
#                  (0..blockambig).each { |ambig|
#                    if !block_listed[s] then
#                      if (newstate[ambig] & @asearch.acceptpat) != 0 then # マッチ
#                        block_listed[s] = true
#                        yield [s] + ss
#                      end
#                    end
#                  }
#                else

              maxambig = 2
              for ambig in [0..maxambig]
                console.log "ambig = #{ambig}"
                if !listed[ambig][s]
                  console.log "newstate[ambig] = #{newstate[ambig]}"
                  if (newstate[ambig] & @asearch.acceptpat) != 0
                    maxambig = ambig if ambig < maxambig # 曖昧度0でマッチすれば曖昧度1の検索は不要
                    listed[ambig][s] = true
                    sslen = ss.length
                    if sslen > 0
                      patstr = (["(.*)"] * sslen).join("\t")
                      console.log "patstr = #{patstr}"
                      /#{patstr}/.match ss.join("\t")
                    # 'set date #{$2}' のような記述の$変数にsubstringの値を代入
                    # res[ambig].push [s, eval('%('+@commands[acceptno]+')')]
                    res[ambig].push [s, '---']

      break if newlist.length == 0
      lists.push newlist
      break if res[0].length > 100
      console.log lists

    [res[0], res[1], res[2]]

# g = new Generator("abc")
# console.log g.generate("bc")

module.exports = Generator
