--[[ format-nvim config
  TODO:
  - Integrate language servers
  - Integrate clang-tidy (c, cpp)
  - Limit rustfmt to one file
  ]]
local cmdgen = {
  prettier = [[prettier -w --parser %s --config-precedence prefer-file --no-semi --single-quote]]
}

require'format'.setup {
  ['*'] = {{ cmd = {
    [[sed -i 's/[ \t]*$//']], -- Remove trailing whitespace
    [[sed -i ':a; /^$/ { $d; N; ba; }']], -- Remove trailing blank lines
  }}},
  c = {{ cmd = {'clang-format -i'} }},
  cmake = {{ cmd = {'cmake-format -i'} }},
  cpp = {{ cmd = {'clang-format -i'} }},
  css = {
    { cmd = { cmdgen.prettier:format 'css' } },
  },
  go = {
    { cmd = {'gofmt -w', 'goimports -w'}, tempfile_postfix = '.tmp' },
  },
  html = {
    { cmd = { cmdgen.prettier:format 'html' } },
  },
  javascript = {
    { cmd = { cmdgen.prettier:format 'javascript' } },
  },
  json = {
    { cmd = { cmdgen.prettier:format 'json' } },
  },
  less = {
    { cmd = { cmdgen.prettier:format 'less' } },
  },
  markdown = {
    { cmd = { cmdgen.prettier:format 'markdown' } },
  },
  python = {{ cmd = {'isort'} }},
  rust = {{ cmd = {'rustfmt'} }}, -- NOTE This can format multiple files
  scss = {
    { cmd = { cmdgen.prettier:format 'scss' } },
  },
  sh = {{ cmd = {'shfmt -i=2 -ci -w'} }},
  sql = {
    { cmd = { function(file) return ([[sqlformat -r %s -o %s]]):format(file, file) end } },
  },
  toml = {{ cmd = {'taplo format'} }},
  typescript = {
    { cmd = { cmdgen.prettier:format 'typescript' } },
  },
  xml = {
    { cmd = { function(file) return ([[xmllint --format %s -o %s]]):format(file, file) end } }
  },
  yaml = {
    { cmd = { cmdgen.prettier:format 'yaml' } },
  },
}

vim.cmd [[autocmd init BufWritePost * FormatWrite]]