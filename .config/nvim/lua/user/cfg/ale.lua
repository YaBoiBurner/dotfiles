-- Standalone ALE config
vim.g.ale_fix_on_save = true
vim.g.ale_disable_lsp = true
vim.g.ale_linters_ignore = {
  --[[
    I'm using this to disable linters that should not be handled by ALE.
    That includes stuff handled by another plugin, and stuff that isn't helpful.

    potential things to convert:
    - fecs [ css, html, javascript ]
    - gawk [ awk ] (packaged)
    - clangcheck [ cpp ] (packaged)
    - cppcheck [ c, cpp ] (packaged)
    - clazy [ cpp ] (packaged)
    - flawfinder [ c, cpp ] (packaged)
    - vale [ asciidoc, mail, markdown, rst, tex, text ]
    - msgfmt [ po ] (packaged)
    - redpen [ asciidoc, markdown, review, rst, tex, text ]
    - textlint [ asciidoc, markdown, rst, tex, text ]
    - chktex [ tex ] (packaged)
    - lacheck [ tex ] (packaged)
  ]]
  asciidoc = { 'alex', 'languagetool', 'proselint', 'writegood' },
  bats = { 'shellcheck' },
  c = { 'cc', 'clangtidy', 'cpplint' },
  cmake = { 'cmakelint' },
  cpp = { 'cc', 'clangtidy', 'cpplint' },
  css = { 'csslint', 'stylelint' },
  dockerfile = { 'hadolint' },
  elixir = { 'credo' },
  eruby = { 'erb' },
  fish = { 'fish' },
  fountain = { 'proselint' },
  gitcommit = { 'gitlint' },
  graphql = { 'eslint' },
  help = { 'alex', 'proselint', 'writegood' },
  html = { 'alex', 'proselint', 'tidy', 'writegood' },
  javascript = { 'eslint', 'jshint', 'flow', 'standard', 'xo' },
  json = { 'jsonlint', 'jq', 'spectral' },
  -- jsonc = { 'jsonlint', 'spectral' },
  less = { 'stylelint' },
  lua = { 'luacheck', 'luac' },
  mail = { 'alex', 'languagetool', 'proselint' },
  markdown = { 'alex', 'languagetool', 'markdownlint', 'proselint', 'writegood' },
  nroff = { 'alex', 'proselint', 'writegood' },
  objc = { 'clang' },
  objcpp = { 'clang' },
  php = { 'phpcs', 'phpstan' },
  po = { 'alex', 'proselint', 'writegood' },
  pod = { 'alex', 'proselint', 'writegood' },
  python = { 'flake8', 'mypy', 'pylint' },
  rst = { 'alex', 'proselint', 'rstcheck', 'writegood' },
  rust = { 'cargo' },
  sass = { 'stylelint' },
  scss = { 'stylelint' },
  sh = { 'bashate', 'shellcheck' },
  sql = { 'sqlint' },
  stylus = { 'stylelint' },
  sugarss = { 'stylelint' },
  teal = { 'tlcheck' },
  tex = { 'alex', 'proselint', 'writegood' },
  texinfo = { 'alex', 'proselint', 'writegood' },
  typescript = { 'eslint', 'standard', 'tslint', 'xo' },
  vim = { 'vint' },
  vimwiki = { 'alex', 'languagetool', 'proselint', 'markdownlint', 'mdl', 'remark-lint', 'writegood' },
  vue = { 'eslint' },
  xhtml = { 'alex', 'proselint', 'writegood' },
  xsd = { 'xmllint' },
  xml = { 'xmllint' },
  xslt = { 'xmllint' },
  yaml = { 'spectral', 'yamllint' },
  zsh = { 'shell' },
}
vim.g.ale_fixers = {
  ['*'] = { 'remove_trailing_lines', 'trim_whitespace' },
  cpp = { 'clangtidy', 'remove_trailing_lines', 'trim_whitespace' },
  go = { 'gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace' },
  html = { 'tidy', 'remove_trailing_lines', 'trim_whitespace' },
  markdown = {},
  python = {
    'add_blank_lines_for_python_control_statements',
    'reorder-python-imports',
    'remove_trailing_lines',
    'trim_whitespace',
  },
  rust = { 'rustfmt', 'remove_trailing_lines', 'trim_whitespace' },
  sql = { 'sqlformat', 'remove_trailing_lines', 'trim_whitespace' },
  xml = { 'xmllint' },
}
vim.cmd [[autocmd init VimEnter * lua require('user.cleanup.ale')]]