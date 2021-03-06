" File: after/syntax/vim.vim
" Author: Jaden Pleasants
" Description: Extensions to vim syntax
" Last Modified: October 10, 2019

scriptenc 'utf-8'

syn cluster vimRegGroups contains=vimRegGroup,vimRegEither,vimRegCondit
syn cluster vimRegAnchors contains=vimRegStr,vimRegMatch,vimRegWord,vimRegWeird
syn cluster vimRegMeta contains=vimRegLiteral,vimRegNonAscii,vimRegReference,vimRegAny
syn cluster vimRegQuant contains=vimRegQuantity,vimReg0Or1,vimReg1OrMore,vimRegGreedy
syn cluster vimRegChars contains=vimRegChar,vimRegCharClass
syn cluster vimRegCluster contains=vimRegFlag,vimRegErr,vimRegNumber,@vimRegAnchors,@vimRegChars,@vimRegGroups,@vimRegMeta,@vimRegQuant
syn cluster vimDictGroup contains=vimDictString,vimDictKey,vimDictStrFix,vimDictPrimitive,@vimOperGroup

syn cluster vimOperGroup add=vimVar
syn cluster vimStringGroup add=@vimRegCluster
syn cluster vimSubstList add=@vimRegCluster
syn cluster vimSynRegGroup add=@vimRegCluster
syn cluster vimSynRegPatGroup add=@vimRegCluster


" Syntax definitions {{{1
" Syntax: multi-line commands {{{2
" The expression for a continuation line is `/^\s*\\/`.
" So for us to properly extend weird regions, such as the ones used for
" :syn-region, we need to have things end on a line which matches the inverse
" of a continuation line.
" The best expression I've been able to come up with is `/^\%(\s*\\\)\@!/`.
" It's not great, since it relies upon a lookahead, but I've been unable to
" come up with anything else.
syn region vimSynRegion contained keepend
      \ matchgroup=vimGroupName
      \ start=+\h\w*+
      \ skip=+\\\\\|\\|+
      \ matchgroup=vimSep
      \ end=+|+
      \ end=+^\%(\s*\\\)\@!+
      \ contains=@vimSynRegGroup,vimContinue

syn region vimSynMatchRegion contained keepend
      \ matchgroup=vimGroupName
      \ start=+\h\w*+
      \ skip=+\\\\\|\\|+
      \ matchgroup=vimSep
      \ end=+|+
      \ end=+^\%(\s*\\\)\@!+
      \ contains=@vimSynMtchGroup,vimContinue

syn region vimSynKeyRegion contained keepend
      \ matchgroup=vimGroupName
      \ start=+\h\w*+
      \ skip=+\\\\\|\\|+
      \ matchgroup=vimSep
      \ end=+|+
      \ end=+^\%(\s*\\\)\@!+
      \ contains=@vimSynKeyGroup,vimContinue

" Syntax: conceal {{{2
" This was outright missing from the default syntax. Why I don't know.
syn match vimSynType contained skipwhite 'conceal' nextgroup=vimSynConcealOpt
syn keyword vimSynConcealOpt contained on off

" Variables: Constants {{{2
" A lot of Vim variables are constants.
" Stupidly enough, we can get a list of Vim vars by listing the keys in v:.
exe 'syn match vimConstant contained /\<v:\%('.join(keys(v:), '\|').'\)/ containedin=vimVar'

" Variables: Booleans & nulls {{{2
" I was going to write a comment here about how stupid it is that booleans and
" nulls are actually v: variables, but shellscript hasn't even thought to add
" concepts such as booleans to it so I'll take what I can get.
syn match vimBoolean contained '\<v:\%(true\|false\)\>'
      \ containedin=vimVar contains=vimBoolHide
syn match vimBoolHide contained transparent conceal '\<v:'

" Variables: Missing scopes & edge cases {{{2
syn match vimVar '\[\zs&\a\+\>' " options in 'let []'
syn match vimVar contained '\zs&\a\+\>' containedin=vimFuncBodyList
syn match vimVar '&\<[lg]:\a\+\>' " local/global options

" Autocmd {{{2
syn match vimAutoCmdSfxList contained skipwhite '\S*'
      \ nextgroup=vimCommand,vimAutoCmdExtend
syn match vimAutoCmdExtend contained '^\s*\\|.*$' contains=vimContinue

" Maps {{{2
syn match vimMapRhs contained skipnl '.*\%(\s*|$\)\@!'
      \ contains=vimNotation,vimCtrlChar nextgroup=vimMapRhsExtend
syn match vimMapRhs contained '.*\ze\s\+|$' contains=vimNotation,vimCtrlChar
syn clear vimMapRhsExtend
syn match vimMapRhsExtend contained '^\s*\\[^|].*$' contains=vimContinue

" Regexp: rewritten enhancements {{{2
" Clusters {{{3
" Entrypoints {{{3

" Regexp: hidden {{{2
syn match vimRegHide    contained transparent conceal '\\'
syn match vimRegHideStr contained transparent conceal '\\_'
syn match vimRegHideGrp contained transparent conceal '\\%\?'

" Regexp: Special Characters {{{2
" NOTE: Literals fail to match without the lookbehind :(
" NOTE: This is intentionally inaccurate.
syn match vimRegLiteral   contained '\%(\%(\\\\\)*\)\@<=\\\W'
" invalid literals: \c[1-9a-fhik-pr-z_+=?_@&<>%(|){]
"   + substitution: \c[[:digit:]a-fhik-pr-z_+=?_@&<>%(|){] : +0
"       + reserved: \c[[:alnum:]_+=?_@&<>%(|){]         : +gjq
syn match vimRegAny       contained '\%(\\\\\)*\zs\%[\\_]\.'
syn match vimRegNonAscii  contained '\%(\\\\\)*\zs\\%d\d\+'
syn match vimRegNonAscii  contained '\%(\\\\\)*\zs\\%o\o\{2,4}'
syn match vimRegNonAscii  contained '\%(\\\\\)*\zs\\%x\x\{1,2}'
syn match vimRegNonAscii  contained '\%(\\\\\)*\zs\\%u\x\{1,4}'
syn match vimRegNonAscii  contained '\%(\\\\\)*\zs\\%U\x\{1,8}'
syn match vimRegNonAscii  contained '\%(\\\\\)*\zs\\%C'
syn match vimRegReference contained '\%(\\\\\)*\zs\\\d'
" NOTE: The incorrect \0 match is to improve performance.

" Regexp: Weird anchors {{{2
" NOTE: This has conflicts with and should be clobbered by Flags.
syn match vimRegWeird contained '\%(\\\\\)*\zs\\%\%([\^$V#]\|[<>]\?\'m\)'
syn match vimRegWeird contained '\%(\\\\\)*\zs\\%[<>]\?\d+[lcv]'

" Regexp: flags {{{2
" syn match vimRegFlag contained '\%(\\\\\)*\zs\\[mMvVcCZ]'
syn match vimRegFlag contained '\%(\\\\\)*\zs\\%#=[012]'

" Regexp: Anchors {{{2
syn match vimRegStr contained '\%(^|[\'"/]\)\zs\^'
syn match vimRegStr contained '\$\_$'
syn match vimRegStr contained '\%(\\\\\)*\zs\\_[\^$]' contains=vimRegHideStr
syn match vimRegMatch  contained '\%(\\\\\)*\zs\\z[se]'
syn match vimRegWord   contained '\%(\\\\\)*\zs\\[<>]' contains=vimRegHide

" Regexp: Quantifiers {{{2
syn match vimRegQuantity contained '\%(\\\\\)*\zs\\{-\?\d*\%(,\d*\)\?}'
      \ contains=vimRegUnsafeNumber,vimRegHide
syn match vimReg1OrMore contained '\%(\\\\\)*\zs\\+' contains=vimRegHide
syn match vimReg0Or1    contained '\%(\\\\\)*\zs\\?' contains=vimRegHide
syn match vimReg0Or1    contained '\%(\\\\\)*\zs\\=' conceal cchar=?
syn match vimRegGreedy  contained '\%(\\\\\)*\zs\*'
syn match vimRegGreedy  contained '\%(\\\\\)*\zs\\{-\?}' conceal cchar=*
" NOTE: People who use {} deserve the death

" Regexp: Groups {{{2
" NOTE: While a region would be preferable for this, there doesn't seem to be
" any way to only conceal a part of the ends. It's either 'concealends', which
" conceals nothing, or this, which at least looks the way it's supposed to.
syn match vimRegGroup contained '\%(\\\\\)*\zs\\%\?(' contains=vimRegHideGrp
syn match vimRegGroup contained '\%(\\\\\)*\zs\\)' contains=vimRegHide
syn match vimRegEither contained '\%(\\\\\)*\zs\\|' contains=vimRegHide

" Regexp: Conditions {{{2
syn match vimRegErr contained '\%(\\\\\)*\zs\\@\d*<\?\ze[\'"/]\?'
" NOTE: The error is inaccurate so the correct syntax replaces it.
syn match vimRegCondit contained '\%(\\\\\)*\zs\\@\%(\%(\d*<\)\?[=!]\|>\)'
syn match vimRegCondit contained '\%(\\\\\)*\zs\\&'
" NOTE: \& = \@!

" Regexp: Characters {{{2
syn match vimRegChar contained '\%(\\\\\)*\zs\\[etrbn]'
syn match vimRegCharClass contained '\%(\\\\\)*\zs\c\\_\?[ikfpsdxowhalu]'

" Regexp: Numbers {{{2
syn match vimRegNumber contained '\%(\\\\\)*\zs\d\+'
syn match vimRegUnsafeNumber contained '\d\+'

" Regexp: Errors {{{2
" These errors will cause the regex engine to fail.
syn match vimRegErr contained '\%(\\\\\)*\zs\\%#=\%(\ze[\'"/]\|[^012]\)'
syn match vimRegErr contained
      \ '\%(\\\\\)*\zs\\z\%(\ze[\'"/]\|[^se[:digit:](]\)'
syn match vimRegErr contained
      \ '\%(\\\\\)*\zs\\_\%(\ze[\'"/]\|\c[^ikfpsdxowhalu\^$.\[]\)'

" These are just bad syntax
syn match vimRegErr contained '\%(\\\\\)*\zs\\[ETRBNgGjJqQ]' " reserved escapes
syn match vimRegErr contained '\%(\\\\\)*\zs\\{-,}' " syntax error, not too problematic

" Dictionaries: Enhanced #{} dictionaries {{{2
" Some of this still runs into edge cases that I need to fix, but its mostly
" when there are errors so it's low priority.
" The easiest one to cause is with a string and a string key on one line.
syn cluster vimHashDictGroup contains=vimHashDictKey,vimHashDictKeyError
syn region vimOperParen
      \ matchgroup=vimSep
      \ start="#{" end="}"
      \ contains=@vimOperGroup,@vimHashDictGroup
      \ nextgroup=vimVar,vimFuncVar

" Keys can only consist of ASCII letters, digits, '-', and '_'
syn match vimHashDictKeyError contained '\%(:\s\+\)\@<!\S\+\ze\s*:' nextgroup=@vimOperGroup

" We CANNOT use `'key':`.
" This is based on vimString.
syn region vimHashDictKeyError
      \ contained oneline keepend
      \ start=+[^a-zA-Z>!\\@]"+lc=1
      \ skip=+\\\\\|\\"+
      \ end=+"\ze\s*:+
syn region vimHashDictKeyError
      \ contained oneline keepend
      \ start=+[^a-zA-Z>!\\@]'+lc=1
      \ end=+'\ze\s*:+

" XXX I don't think it's possible to check for other errors

syn match vimHashDictKey contained '\%(:\s\+\)\@<![0-9A-Za-z_-]\+\ze\s*:' nextgroup=@vimOperGroup

" Dictionaries: make it look like JSON {{{2
" Effectively concealing dictionaries is a pain in the ass, but it can be
" done. Normally they're handled by vimOperParen but this overrides that.

" syn region vimOperParen
"       \ matchgroup=vimSep
"       \ start=+{+ end=+}+
"       \ contains=@vimDictGroup
"       \ nextgroup=vimVar,vimFuncVar

" For keys and strings, things get a little stupid. If we define keys first,
" then strings will override them. But if we define strings first, keys will
" sometimes extend farther than they're supposed to. This could be fixed by
" using a super region that contains both keys and strings, but then we loose
" the ability to actually detect whether something is a string or a key. Of
" course we can fix that by removing the matchgroup, but that breaks
" concealends. Of course we could try to hand concealends in the child
" regions, but then I guess we get back to keys extending farther than they're
" supposed to pLEASE KILL ME
"
" define strings first.
" then keys to override strings.
" then matches that override erroneous keys.
" syn region vimDictString contained oneline keepend
"       \ matchgroup=vimDictQuoteS
"       \ start=+[^a-zA-Z>!\\@]\z(['"]\)+lc=1
"       \ skip=+\\\\\|\\\z1+
"       \ end=+\z1+
"       \ contains=@vimStringGroup

" syn region vimDictKey contained oneline keepend
"       \ matchgroup=vimDictQuoteK
"       \ start=+[^a-zA-Z>!\\@]\z(['"]\)+lc=1
"       \ skip=+\\\\\|\\\z1+
"       \ end=+\z1\ze:+

" syn match vimDictStrFix contained transparent +'[^']\+'\ze[^:]+ contains=vimDictString

" syn match vimDictPrimitive contained 'v:\%(true\|false\|null\)' contains=vimDictPrimConceal
" syn match vimDictPrimConceal contained transparent conceal 'v:'

" Highlight settings {{{1
hi def link vimRegFlag PreCondit

hi def link vimRegWeird Operator
hi def link vimRegStr Operator
hi def link vimRegWord Operator
hi def link vimRegMatch Operator

hi def link vimRegLiteral SpecialChar
hi def link vimRegAny SpecialChar
hi def link vimRegNonAscii Special
hi def link vimRegReference Identifier

hi def link vimRegQuantity Delimiter
hi def link vimReg0Or1 Number
hi def link vimReg1OrMore Number
hi def link vimRegGreedy Number

hi def link vimRegGroup Delimiter
hi def link vimRegEither Operator
hi def link vimRegCondit Conditional

hi def link vimRegChar SpecialChar
hi def link vimRegCharClass Structure

hi def link vimRegNumber Number
hi def link vimRegUnsafeNumber Number

hi def link vimSubstSubstr Identifier

hi def link vimRegNum Number
hi def link vimRegErr Error

hi def link vimSynConcealOpt vimSynType
hi def link vimConstant Constant
hi def link vimBoolean Boolean

hi def link vimDictString vimString
hi def link vimDictQuoteS vimDictString
hi def link vimDictKey Keyword
hi def link vimDictQuoteK vimDictKey
hi def link vimDictPrimitive vimConstant

hi def link vimHashDictKey Label
hi def link vimHashDictKeyError Error

" vim:ft=vim fdm=marker
