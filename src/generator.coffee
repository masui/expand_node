#          ( (  )  )  ( (    ) (  (  )  ) (   )  )  | (  (  )  )
#  pars   [1]     
#           [1,2]
#                    [3]
#                     [3,4]
#                             [3,5]

Scanner = require './scanner'
RegExp = require './regexp'
Asearch = require 'asearch'

#a = new Asearch 'abcde'
#console.log a.match 'abcde' # => true
#console.log a.match 'AbCdE' # => true
#console.log a.match 'abcd' # => false
#console.log a.match 'abcd', 1 # => true
#console.log a.match 'ab de', 1 # => true
#console.log a.match 'abe', 1 # => false
#console.log a.match 'abe', 2 # => true

class GenNode
  constructor: (@id, @state=[], @s="", @substrings=[], @accept=false) ->
  

class Generator
  constructor: (s = nil) ->
    @s = if s then  [s] else []
    @matchedlist = []
    @par = 0
    @commands = []

  add: (pat,command) ->
    @s << pat
    @commands << command

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
#      #
#      # 状態遷移機械からDepth-Firstで文字列を生成する
#      # n個のノードを経由して生成される状態の集合をlists[n]に入れる
#      # 生成しながらマッチングも計算する
#      #
#      lists = []
#      listed = [{},{},{}]
#      block_listed = {}
#      #
#      # 初期状態
#      #
#      list = []
#      list[0] = GenNode.new(startnode.id, @asearch.initstate)
#      lists[0] = list
#      #
#      loopcount = 0
#      (0..10000).each { |length|
#      #loop do 
#      #  length = loopcount
#        list = lists[length]
#        newlist = []
#        # puts "#{length} - #{list.length}"
#        list.each { |entry|
#          srcnode = Node.node(entry.id)
#          if list.length * srcnode.trans.length < 100000 then
#            srcnode.trans.each { |trans|
#              ss = entry.substrings.dup
#              srcnode.pars.each { |i|
#                ss[i-1] = ss[i-1].to_s + trans.arg
#              }
#              newstate = @asearch.state(entry.state, trans.str) # 新しいマッチング状態を計算してノードに保存
#              s = entry.s + trans.str
#              acceptno = trans.dest.accept
#              newlist << GenNode.new(trans.dest.id, newstate, s, ss, acceptno)
#              #
#              # この時点で、マッチしているかどうかをstateとacceptpatで判断できる
#              # マッチしてたら出力リストに加える
#              #
#              if acceptno then
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
#                  maxambig = 2
#                  (0..maxambig).each { |ambig|
#                    if !listed[ambig][s] then
#                      if (newstate[ambig] & @asearch.acceptpat) != 0 then # マッチ
#                        maxambig = ambig if ambig < maxambig # 曖昧度0でマッチすれば曖昧度1の検索は不要
#                        listed[ambig][s] = true
#                        sslen = ss.length
#                        if sslen > 0 then
#                          # patstr = "(.*)\t" * (sslen-1) + "(.*)"
#                          patstr = (["(.*)"] * sslen).join("\t")
#                          /#{patstr}/ =~ ss.join("\t")
#                        end
#                        # 'set date #{$2}' のような記述の$変数にsubstringの値を代入
#                        res[ambig] << [s, eval('%('+@commands[acceptno]+')')]
#                      end
#                    end
#                  }
#                end
#              end
#            }
#          end
#        }
#        break if newlist.length == 0
#        lists << newlist
#        break if res[0].length > 100
#      # loopcount += 1
#      #end
#      }
#      [res[0], res[1], res[2]]
#    end
#    

g = new Generator("ab(c|d|e)")
g.generate("a")

# module.exports = Generator
