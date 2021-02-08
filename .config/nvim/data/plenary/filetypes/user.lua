--[[ Filetype notes
  Known issues:
  - JSON With comments isn't detected (this is a general issue right now)
  - Shebang detection isn't great (plenary issue)
      In more detail, it only does exact matches, so it misses anything with arguments

  Other notes:
  - Zsh is present in here a lot to override base settings
  ]]
local shebang_prefixes = { '/usr/bin/', '/bin/', '/usr/bin/env ', '/bin/env ' }
local shebang_fts = {
  ['awk -f'] = 'awk', -- Needed for plenary to work
  ['fennel'] = 'fennel',
  ['fish'] = 'fish',
  ['gawk -f'] = 'awk', -- Needed for plenary to work
  ['gjs'] = 'javascript', -- GJS Scripts
  ['gjs-console'] = 'javascript', -- GJS Scripts
  ['lua'] = 'lua',
  ['moon'] = 'moon',
  ['node'] = 'javascript',
  ['ruby'] = 'ruby',
  ['tl'] = 'teal',
}
local shebang = {}
for _, prefix in ipairs(shebang_prefixes) do
  for k, v in pairs(shebang_fts) do
    shebang[prefix .. k] = v
  end
end
local special = {
  asa = (vim.g.filetype_asa or 'aspvbs'),
}

return {
  extension = {
    ['aiml'] = 'xml', -- Artificial Intelligence Markup Language
    ['asa'] = special.asa,
    ['cjson'] = 'json', -- FIXME has comments
    ['doap'] = 'xml', -- Description of a project
    ['fish'] = 'fish',
    ['iuml'] = 'plantuml',
    ['jsonc'] = 'json', -- FIXME has comments
    ['jsonld'] = 'json', -- JSON Linked Data
    ['ll'] = 'llvm',
    ['lzx'] = 'xml', -- OpenLaszlo
    ['moon'] = 'moon',
    ['pip'] = 'requirements',
    ['plantuml'] = 'plantuml',
    ['posxml'] = 'xml', -- Posxml
    ['pu'] = 'plantuml',
    ['puml'] = 'plantuml',
    ['resjson'] = 'json', -- Windows App localization
    ['ron'] = 'ron',
    ['snippets'] = 'snippets',
    ['spec'] = 'spec', -- RPM Spec
    ['td'] = 'tablegen',
    ['tl'] = 'teal',
    ['tmLanguage'] = 'xml', -- Textmate language
    ['toml'] = 'toml',
    ['uml'] = 'plantuml',
    ['wrap'] = 'dosini', -- From meson.vim
    ['xlisp'] = 'lisp',
    ['zsh'] = 'zsh',
    ['ublock.txt'] = 'ublock', -- Custom filetype
  },
  file_name = {
    ['.arclint'] = 'json',
    ['.avcs'] = 'json', -- Avro Schema
    ['.babelrc'] = 'json', -- Babel configuration file (alias to .babelrc.json; has comments)
    ['.bootstraprc'] = 'yaml',
    ['.bowerrc'] = 'json', -- Bower config
    ['.coveragerc'] = 'dosini',
    ['.csslintrc'] = 'json', -- CSS Lint config
    ['.jsbeautifyrc'] = 'json', -- js-beautify config; could have comments
    ['.jscsrc'] = 'json', -- JSCS config
    ['.jshintrc'] = 'json', -- JSHint config; has comments
    ['.jsinspectrc'] = 'json', -- JSInspect config
    ['.jslintrc'] = 'json', -- has comments
    ['.luacompleterc'] = 'json',
    ['.manpath'] = 'manconf', -- User manpath
    ['.modernizrrc'] = 'json', -- Webpack modernizr-loader config
    ['.npmpackagejsonlintrc'] = 'json', -- npm-package-json-lint config
    ['.proselintrc'] = 'json',
    ['.tcelldb'] = 'json',
    ['.viminfo'] = 'viminfo',
    ['.wgetrc'] = 'wget',
    ['.zlogin'] = 'zsh',
    ['.zlogout'] = 'zsh',
    ['.zprofile'] = 'zsh',
    ['.zsh_history'] = 'zshhist', -- Custom filetype
    ['.zshenv'] = 'zsh',
    ['.zshrc'] = 'zsh',
    ['_exrc'] = 'vim',
    ['_viminfo'] = 'viminfo',
    ['anacrontab'] = 'crontab',
    ['cargo.lock'] = 'toml',
    ['constraints.in'] = 'requirements',
    ['constraints.txt'] = 'requirements',
    ['gdbinit'] = 'gdb',
    ['gopkg.lock'] = 'toml',
    ['index.theme'] = 'desktop', -- Icon theme index
    ['man_db.conf'] = 'manconf', -- System mandb config (on Fedora)
    ['meson.build'] = 'meson',
    ['meson_options.txt'] = 'meson',
    ['mimeapps.list'] = 'desktop', -- XDG Default Applications
    ['mimeinfo.cache'] = 'desktop', -- XDG Mime cache
    ['pipfile'] = 'toml',
    ['proselintrc'] = 'json',
    ['requirements.in'] = 'requirements',
    ['requirements.txt'] = 'requirements',
    ['requires.in'] = 'requirements',
    ['requires.txt'] = 'requirements',
    ['robots.txt'] = 'robots',
    ['virc'] = 'vim',
    ['wgetrc'] = 'wget',
    ['zlogin'] = 'zsh',
    ['zlogout'] = 'zsh',
    ['zprofile'] = 'zsh',
    ['zshenv'] = 'zsh',
    ['zshrc'] = 'zsh',
  },
  shebang = shebang
}