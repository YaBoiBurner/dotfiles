-- WIP port of my variant of tyrannicaltoucan/vim-quantum to colorbuddy
local Color, c, Group, g, s = require('colorbuddy').setup()

-- Base colors
Color.new('gray_1', '#212121')
Color.new('gray_2', '#292929')
Color.new('gray_3', '#474646')
Color.new('gray_4', '#6a6c6c')
Color.new('gray_5', '#b7bdc0')
Color.new('red',    '#dd7186')
Color.new('green',  '#87bb7c')
Color.new('yellow', '#d5b875')
Color.new('blue',   '#70ace5')
Color.new('purple', '#a48add')
Color.new('cyan',   '#69c5ce')
Color.new('orange', '#d7956e')
Color.new('indigo', '#7681de')

-- Groups - Vim
-- group, fg, bg, styles
Group.new('ColorColumn',  nil,      c.gray_2)
Group.new('Cursor',       c.gray_2, c.gray_5)
Group.new('CursorColumn', nil,      c.gray_2)
Group.new('CursorLine',   nil,      c.gray_2, s.NONE)
Group.new('CursorLineNr', c.cyan,   c.gray_2, s.NONE)
Group.new('Directory',    c.blue,   nil)
Group.new('DiffAdd',      c.green,  c.gray_2, s.NONE)
Group.new('DiffChange',   c.yellow, c.gray_2, s.NONE)
Group.new('DiffDelete',   c.red,    c.gray_2, s.NONE)
Group.new('DiffText',     c.blue,   c.gray_2, s.NONE)
Group.new('ErrorMsg',     c.red,    c.gray_1, s.bold)
Group.new('FoldColumn',   c.gray_4, c.gray_1)
Group.new('Folded',       c.gray_3, c.gray_1)
Group.new('IncSearch',    c.yellow, nil)
Group.new('LineNr',       c.gray_3, nil)
Group.new('MatchParen',   c.gray_4, c.cyan,   s.bold)
Group.new('ModeMsg',      c.green,  nil)
Group.new('MoreMsg',      c.green,  nil)
Group.new('NonText',      c.gray_4, nil,      s.NONE)
Group.new('Normal',       c.gray_5, c.gray_1, s.NONE)
Group.new('Pmenu',        c.gray_5, c.gray_3)
Group.new('PmenuSbar',    nil,      c.gray_2)
Group.new('PmenuSel',     c.gray_2, c.cyan)
Group.new('PmenuThumb',   nil,      c.gray_4)
Group.new('Question',     c.blue,   nil,      s.NONE)
Group.new('Search',       c.gray_1, c.yellow)
Group.new('SignColumn',   c.gray_5, c.gray_1)
Group.new('SpecialKey',   c.gray_4, nil)
Group.new('SpellCap',     c.blue,   c.gray_2, s.undercurl)
Group.new('SpellBad',     nil,      nil,      s.undercurl) -- defaults: c.red, c.gray_2, s.undercurl
Group.new('StatusLine',   c.gray_5, c.gray_3, s.NONE)
Group.new('StatusLineNC', c.gray_2, c.gray_4)
Group.new('TabLine',      c.gray_4, c.gray_2, s.NONE)
Group.new('TabLineFill',  c.gray_4, c.gray_2, s.NONE)
Group.new('TabLineSel',   c.yellow, c.gray_3, s.NONE)
Group.new('Title',        c.green,  nil,      s.NONE)
Group.new('VertSplit',    c.gray_4, c.gray_1, s.NONE)
Group.new('Visual',       c.gray_5, c.gray_3)
Group.new('WarningMsg',   c.red,    nil)
Group.new('WildMenu',     c.gray_2, c.cyan)

-- Groups - Standard syntax
-- group, fg, bg, styles
Group.new('Comment',    c.gray_4, nil,      s.italic)
Group.new('Constant',   c.orange, nil)
Group.new('String',     c.green,  nil)
Group.new('Character',  c.green,  nil)
Group.new('Identifier', c.red,    nil,      s.NONE)
Group.new('Function',   c.blue,   nil)
Group.new('Statement',  c.purple, nil,      s.NONE)
Group.new('Operator',   c.cyan,   nil)
Group.new('PreProc',    c.cyan,   nil)
Group.new('Include',    c.blue,   nil)
Group.new('Define',     c.purple, nil,      s.NONE)
Group.new('Macro',      c.purple, nil)
Group.new('Type',       c.yellow, nil,      s.NONE)
Group.new('Typedef',    c.yellow, nil,      s.bold)
Group.new('Structure',  c.cyan,   nil)
Group.new('Special',    c.indigo, nil)
Group.new('Underlined', c.blue,   nil,      s.NONE)
Group.new('Error',      c.red,    c.gray_1, s.bold)
Group.new('Todo',       c.orange, c.gray_1, s.bold)
