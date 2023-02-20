import os
import std/strutils
import std/parseopt

proc recursiveSearch(depth: int) =
  if depth == 0: # 再帰の深さが0の場合、何もしない
    return
  let currentDir = getCurrentDir()
  for file in walkDir(currentDir):
    if file.kind == pcFile:
      echo file.path
    elif file.kind == pcDir:
      echo file.path
      recursiveSearch(depth - 1) # 再帰的にディレクトリを探索

proc getArgs() =
  var p = initOptParser(shortNoVal = {'c'}, longNoVal = @["second"])
  for kind, key, val in p.getopt():
    case kind
    of cmdShortOption:
      case key
      of "n": recursiveSearch(val.parseInt)
    else: continue

# プログラムのエントリーポイント
when isMainModule:
  getArgs()
