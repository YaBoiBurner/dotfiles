setl formatexpr=CocAction('formatSelected')

com! -buffer -nargs=0 Prettier :CocCommand prettier.formatFile
com! -buffer -nargs=0 Tsc :CocCommand tsserver.watchBuild
