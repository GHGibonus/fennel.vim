" Vim syntax file
" Language: FENNEL
" Maintainer: Calvin Rose

if exists("b:current_syntax")
    finish
endif

let s:cpo_sav = &cpo
set cpo&vim

if has("folding") && exists("g:fennel_fold") && g:fennel_fold > 0
    setlocal foldmethod=syntax
endif

syntax iskeyword @,48-57,192-255,!,$,%,&,#,*,+,.,/,:,<,=,>,?,_,\,-,~

syntax keyword FennelCommentTodo contained FIXME XXX TODO FIXME: XXX: TODO:


syn match FennelComment ";.*$" contains=FennelCommentTodo,@Spell " FENNEL comments

syntax region FennelListReg start="(" end=")" contains=ALL fold

syntax match FennelStringEscape '\v\\%([abfnrtv'"\\]|x[[0-9a-fA-F]]\{2}|25[0-5]|2[0-4][0-9]|[0-1][0-9][0-9])' contained
syntax region FennelString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=FennelStringEscape,@Spell
syntax region FennelString matchgroup=FennelStringDelimiter start=/:/ end=/\>/ contains=@Spell

syn keyword FennelConstant nil

syn keyword FennelBoolean true false

syntax keyword FennelSpecialForm
    \ % * + - -> ->> -?> -?>> . .. / // < <= = > >= ^ and comment do doc doto
    \ each eval-compiler for if include lambda length let lua macro macros match
    \ not not= or partial quote require-macros set set-forcibly! tset values var
    \ when while ~= λ fn hasfn global local

syntax keyword LuaSpecialValue
    \ _G _VERSION assert collectgarbage dofile error getmetatable ipairs load
    \ loadfile next pairs pcall print rawequal rawget rawlen rawset require
    \ select setmetatable tonumber tostring type xpcall coroutine
    \ coroutine.create coroutine.isyieldable coroutine.resume coroutine.running
    \ coroutine.status coroutine.wrap coroutine.yield debug debug.debug
    \ debug.gethook debug.getinfo debug.getlocal debug.getmetatable
    \ debug.getregistry debug.getupvalue debug.getuservalue debug.sethook
    \ debug.setlocal debug.setmetatable debug.setupvalue debug.setuservalue
    \ debug.traceback debug.upvalueid debug.upvaluejoin io io.close io.flush
    \ io.input io.lines io.open io.output io.popen io.read io.stderr io.stdin
    \ io.stdout io.tmpfile io.type io.write math math.abs math.acos math.asin
    \ math.atan math.ceil math.cos math.deg math.exp math.floor math.fmod
    \ math.huge math.log math.max math.maxinteger math.min math.mininteger
    \ math.modf math.pi math.rad math.random math.randomseed math.sin math.sqrt
    \ math.tan math.tointeger math.type math.ult os os.clock os.date os.difftime
    \ os.execute os.exit os.getenv os.remove os.rename os.setlocale os.time
    \ os.tmpname package package.config package.cpath package.loaded
    \ package.loadlib package.path package.preload package.searchers
    \ package.searchpath string string.byte string.char string.dump string.find
    \ string.format string.gmatch string.gsub string.len string.lower
    \ string.match string.pack string.packsize string.rep string.reverse
    \ string.sub string.unpack string.upper table table.concat table.insert
    \ table.move table.pack table.remove table.sort table.unpack utf8 utf8.char
    \ utf8.charpattern utf8.codepoint utf8.codes utf8.len utf8.offset ...


" FENNEL numbers
syntax match FennelNumber "\v\c<[-+]?\d*\.?\d*%([eE][-+]?\d+)?>"
syntax match FennelNumber "\v\c<[-+]?0x\x*\.?\x*>"


syntax match FennelIdentifier "$\k*" " anonymous function argument references
syntax match FennelUnquote ",\k\+"

" Function definitions and application (first element of lists)
syntax match FennelFunction /(\s*\k\+/lc=1
syntax match FennelFunction /\<fn\s\+\k\+/lc=2

" Special lists (NOTE: I think they have priority over FennelListReg because
" they are defined afterward)
syntax region FennelAnonFunReg matchgroup=FennelAnonFun start="#(" end=")" contains=ALL fold
syntax region FennelMacroListReg matchgroup=FennelMacroList start=/[`'](/ end=")" contains=ALL fold

syntax sync fromstart

" Highlighting
hi def link FennelComment Comment
hi def link FennelCommentTodo Todo
hi def link FennelNumber Number
hi def link FennelConstant Constant
hi def link FennelSpecialForm Operator
hi def link FennelSpecialFormFn Operator
hi def link LuaSpecialValue StorageClass
hi def link FennelString String
hi def link FennelStringDelimiter Macro
hi def link FennelBoolean Boolean
hi def link FennelIdentifier Identifier
hi def link FennelAnonFun Identifier
hi def link FennelMacroList Macro
hi def link FennelList Function

hi def link FennelUnquote Macro
hi def link FennelStringEscape Special
hi def link FennelFunction Function

let b:current_syntax = "fennel"

let &cpo = s:cpo_sav
unlet! s:cpo_sav
