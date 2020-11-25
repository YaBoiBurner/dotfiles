" Use tree-sitter handle folding
setl foldmethod=expr foldexpr=nvim_treesitter#foldexpr()

if exists('did_coc_loaded')
  nmap <buffer> <silent> gD <Plug>(coc-definition)
  nnor <buffer> <silent> K :call CocActionAsync('doHover')<CR>
endif

" autocmds
aug user_ftplugin
  au! * <buffer>
  if exists('did_coc_loaded')
    " Highlight symbol under cursor on CursorHold
    au CursorHold <buffer> silent call CocActionAsync('highlight')
  endif
aug END
