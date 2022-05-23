" Lemunozm 256 Dark
"  Author: Luis Enrique Muñoz
"     URL: https://github.com/lemunozm/nvim-config/colors/lemunozm.vim
" Created: 2017
" Version: 0.1
"

hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="lemunozm"

" Main
hi Normal ctermfg=15 ctermbg=232
hi Comment ctermfg=243

" Constant
hi Constant ctermfg=34
hi String ctermfg=229
hi Character ctermfg=208
hi Number ctermfg=208
hi Boolean ctermfg=208
hi Float ctermfg=208

" Variable Name
hi Identifier ctermfg=182 cterm=none
hi Function ctermfg=39
hi Member ctermfg=36
hi Variable ctermfg=15
hi Namespace ctermfg=98

" Statement
hi Statement ctermfg=165
hi Conditional ctermfg=220
hi Repeat ctermfg=220
hi Label ctermfg=39
hi Operator ctermfg=246
hi Keyword ctermfg=165
hi Exception ctermfg=165
hi FunctionDecl ctermfg=39
hi cLabel ctermfg=165

" Preprocessor
hi PreProc ctermfg=34
hi Include ctermfg=34
hi Define ctermfg=34
hi Macro ctermfg=34
hi PreCondit ctermfg=34

" Type
hi Type ctermfg=99
hi StorageClass ctermfg=165
hi Structure ctermfg=165
hi Typedef ctermfg=165
hi cppModifier ctermfg=165

" Special
hi Special ctermfg=174
hi SpecialChar ctermfg=174
hi Tag ctermfg=174
hi Delimiter ctermfg=174
hi SpecialComment ctermfg=174
hi Debug ctermfg=174
hi Underlined ctermfg=249
hi Ignore ctermfg=235
hi Error ctermfg=231 ctermbg=167
hi Todo ctermfg=243 cterm=bold ctermbg=345

" Window
hi StatusLine ctermfg=231 ctermbg=237 cterm=none
hi StatusLineNC ctermfg=244 ctermbg=237 cterm=none
hi TabLine ctermfg=249 ctermbg=237 cterm=none
hi TabLineSel ctermfg=255 ctermbg=240 cterm=bold
hi TabLineFill ctermfg=245 ctermbg=237 cterm=none
hi VertSplit ctermfg=237 ctermbg=237 cterm=none

" Menu
hi Pmenu ctermfg=249 ctermbg=237 cterm=none
hi PmenuSel ctermfg=231 ctermbg=244 cterm=none
hi PmenuSbar ctermbg=59 cterm=none
hi PmenuThumb ctermbg=246 cterm=none
hi WildMenu ctermfg=232 ctermbg=98 cterm=none

" Coc plugin
hi CocFloating ctermbg=234
hi CocUnusedHighlight ctermfg=246

" Selection
hi Visual ctermfg=none ctermbg=236
hi VisualNOS ctermfg=235 ctermbg=80

" Message
hi ErrorMsg ctermfg=210
hi WarningMsg ctermfg=140
hi MoreMsg ctermfg=72
hi ModeMsg ctermfg=222 cterm=bold
hi Question ctermfg=38

" Mark
hi Folded ctermfg=244
hi FoldColumn ctermfg=79 ctermbg=233
hi SignColumn ctermfg=184 ctermbg=233
hi ColorColumn ctermbg=233
hi LineNr ctermfg=254 ctermbg=234

hi MatchParen ctermfg=252 ctermbg=240

" Cursor
hi CursorColumn ctermbg=237
hi CursorLine ctermbg=237
hi CursorLineNr ctermfg=249 ctermbg=237

" Search
hi Search ctermfg=215 ctermbg=none cterm=underline
hi IncSearch ctermfg=215 ctermbg=none cterm=underline

" Diff Mode
hi DiffAdd ctermfg=83 ctermbg=233
hi DiffChange ctermfg=185 ctermbg=233
hi DiffText ctermfg=185 ctermbg=233 cterm=bold
hi DiffDelete ctermfg=167 ctermbg=233

" Spell
hi SpellBad ctermfg=217 ctermbg=bg cterm=underline
hi SpellCap ctermfg=189 ctermbg=bg cterm=underline
hi SpellRare ctermfg=168 ctermbg=bg cterm=underline
hi SpellLocal ctermfg=98 ctermbg=bg cterm=underline

" Misc
hi SpecialKey ctermfg=114
hi NonText ctermfg=234
hi Directory ctermfg=103
hi Title ctermfg=109
hi Conceal ctermfg=77
hi Noise ctermfg=247
hi helpHyperTextJump ctermfg=74
hi perlSharpBang ctermfg=244
hi rubySharpBang ctermfg=244
hi jsFuncCall ctermfg=116

" Html
hi javaScriptNumber ctermfg=179
hi htmlTag ctermfg=147
hi htmlEndTag ctermfg=147
hi htmlTagName ctermfg=175
hi htmlString ctermfg=187

" Vim
hi vimFold ctermfg=244
hi vimCommentTitle ctermfg=249

" Diff File
hi diffFile ctermfg=244
hi diffLine ctermfg=186
hi diffAdded ctermfg=107
hi diffRemoved ctermfg=175
hi diffChanged ctermfg=179
hi diffSubname ctermfg=252
hi diffOldLine ctermfg=104

" Mail
hi mailSubject ctermfg=109
hi mailSignature ctermfg=244

" Markdown
hi markdownCode ctermfg=244
hi markdownCodeBlock ctermfg=244
hi markdownItalic ctermfg=252

" C
hi def link cStatement Conditional

" Go
hi goFunction ctermfg=110
hi goMethodCall ctermfg=165
hi goFunctionCall ctermfg=110
hi goDeclType ctermfg=165
hi goArgumentType ctermfg=98
hi goSimpleArguments ctermfg=174

" Haskell
hi haskellIdentifier ctermfg=220
hi haskellKeyword ctermfg=135
hi haskellWhere ctermfg=135
hi haskellLet ctermfg=135
hi haskellConditional ctermfg=135
hi haskellDefault ctermfg=135
hi haskellDecl ctermfg=135
hi haskellInfix ctermfg=135
hi haskellDerive ctermfg=135
hi haskellDeclKeyword ctermfg=135
hi haskellType ctermfg=69
hi def link haskellSeparator Operator
hi def link haskellDelimiter Operator

" Rust
hi rustKeyword ctermfg=171
hi rustAllCaps ctermfg=180
hi rustSelf ctermfg=204
hi rustType ctermfg=99
hi rustFunction ctermfg=39
hi rustFuncName ctermfg=77
hi rustFuncCall ctermfg=39
"hi rustModPath ctermfg=9 "TODO: modify syntax
hi def link rustMacro rustFuncCall
hi def link rustAssert rustMacro
hi def link rustPanic rustMacro
hi def link rustStorage Special
hi def link rustLifetime Special
hi def link rustSuper rustKeyword
hi def link rustModPath rustType
hi def link rustIdentifier rustType
hi def link rustEnumVariant rustType
hi def link rustFlow Conditional
hi def link rustOperator Operator
hi def link rustStructure rustKeyword
hi def link rustUnion rustKeyword
hi def link rustTypedef rustKeyword
hi def link rustAttribute rustAllCaps
hi def link rustDerive rustAllCaps
hi def link rustCommentLineDoc Comment
hi def link rustCommentBlockDoc Comment

" Python
hi pythonFunction ctermfg=39
hi def link pythonDecoratorName pythonDecorator
hi def link pythonClass pythonFunction
hi def link pythonConstant pythonNumber
hi pythonSelf ctermfg=203
hi def link pythonParameters Type
hi def link pythonClassParameters Type
hi def link pythonOperator Operator
hi def link pythonFlow Conditional
hi def link pythonInclude Define
hi def link pythonExceptions pythonVars
hi def link pythonException Conditional
hi pythonBuiltin ctermfg=137

" Elm
hi def link elmType haskellType
hi def link elmNumberType haskellType
hi def link elmFuncName haskellIdentifier
hi def link elmChar elmInt
hi def link elmConditional Typedef
hi def link elmCaseBlockDefinition Typedef
hi def link elmCaseBlockItemDefinition Typedef
hi def link elmTypedef Typedef
hi def link elmAlias Typedef
hi def link elmDelimiter Operator
hi def link elmBraces Operator
hi def link elmCase Typedef

" HTML
hi htmlArg ctermfg=147
hi htmlEvent ctermfg=147

" JS

" CSS

" Pug
hi pugAttributes ctermfg=147

" Vue
hi htmlSpecialTagName cterm=bold ctermfg=11

