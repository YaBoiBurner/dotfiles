" Vim syntax file
" Language: Kitty configuration file
" Maintainer: Jaden Pleasants

" Pre-work {{{1
if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

syn include @Sh syntax/sh.vim

" Syntax definitions {{{1
" Comments {{{2
" Normal comment
syn region  kittyComment oneline fold start='^\s*#:' end='$' contains=@spell
" Commented out code
syn region  kittyComment oneline fold start='^\s*#[^:]' end='$'
" Special regions {{{2
syn keyword kittyBoolean    contained yes no
syn match   kittyNumber     keepend contained /[+-]\?\%(\.\?\d\.\?\)\+/
syn match   kittyNumberGrp  keepend contained /\%([+-]\?\%(\.\?\d\.\?\),\?\s*\)\+/ contains=kittyNumber
syn match   kittyChar       keepend contained /\S/
syn match   kittyCharGrp    keepend contained /\S\+/ contains=kittyChar
syn match   kittyString     keepend contained /.\+/ contains=kittyHexEscape,kittyUniEscape
syn region  kittyString     keepend start=+"+ skip=+\\"+ end=+"+ contains=kittyHexEscape,kittyUniEscape
syn match   kittyColor      keepend contained /#\x\{3}/
syn match   kittyColor      keepend contained /#\x\{6}/
syn match   kittyCommand    transparent skipwhite keepend contained /^\%(auto\|default\|none\|\.\|@\|-\|!neighbor\).\+/ contains=@Sh,kittySpecialArg
syn match   kittySpecialOpt keepend contained /\./
syn keyword kittySpecialOpt contained auto default none
syn keyword kittyLayout     contained stack tall fat grid horizontal vertical
syn match   kittySpecialArg skipwhite contained /@selection/
syn match   kittyGlob       keepend contained /\*/
syn match   kittyHexEscape  keepend contained /\\x\x\+/
syn match   kittyUniEscape  keepend contained /\\u\x\+/

syn keyword kittyInclude include

" Font configuration {{{2
syn keyword kittyConfigItem font_family bold_font italic_font bold_italic_font
syn keyword kittyConfigItem skipwhite font_size adjust_line_height adjust_column_width nextgroup=kittyNumber
syn keyword kittyConfigItem disable_ligatures
syn keyword kittyConfigItem skipwhite box_drawing_scale nextgroup=kittyNumberGrp

" Cursor configuration {{{2
syn keyword kittyConfigItem skipwhite cursor cursor_text_color    nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite cursor_shape                nextgroup=kittyCursrShape
syn keyword kittyConfigItem skipwhite cursor_blink_interval       nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite cursor_stop_blinking_after  nextgroup=kittyNumber

syn keyword kittyCursrShape contained block beam underline

" Scrollback configuration {{{2
syn keyword kittyConfigItem skipwhite scrollback_lines nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite scrollback_pager nextgroup=kittyCommand
syn keyword kittyConfigItem skipwhite scrollback_pager_history_size wheel_scroll_multiplier touch_scroll_multiplier nextgroup=kittyNumber

" Mouse configuration {{{2
syn keyword kittyConfigItem skipwhite mouse_hide_wait             nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite url_color                   nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite url_style                   nextgroup=kittyUrlStyle
syn keyword kittyConfigItem skipwhite open_url_modifiers          nextgroup=kittyKeySeq
syn keyword kittyConfigItem skipwhite open_url_with               nextgroup=kittySpecialOpt,kittyCommand
syn keyword kittyConfigItem skipwhite copy_on_select              nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite strip_trailing_spaces       nextgroup=kittySTSOpts
syn keyword kittyConfigItem skipwhite rectangle_select_modifiers  nextgroup=kittyKeySeq
syn keyword kittyConfigItem skipwhite select_by_word_characters   nextgroup=kittyCharGrp
syn keyword kittyConfigItem skipwhite click_interval              nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite focus_follows_mouse         nextgroup=kittyBoolean

syn keyword kittyUrlStyle contained none single double curly
syn keyword kittySTSOpts  contained never always smart

" Performance tuning options {{{2
syn keyword kittyConfigItem skipwhite repaint_delay input_delay nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite sync_to_monitor nextgroup=kittyBoolean

" Terminal bell options {{{2
syn keyword kittyConfigItem skipwhite enable_audio_bell     nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite visual_bell_duration  nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite window_alert_on_bell bell_on_tab nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite command_on_bell       nextgroup=kittyCommand,kittySpecialOpt

" Window layout options {{{2
syn keyword kittyConfigItem skipwhite remember_window_size nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite initial_window_height initial_window_width nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite enabled_layouts             nextgroup=kittyGlob,kittyLayout
syn keyword kittyConfigItem skipwhite window_resize_step_cells window_resize_step_lines nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite window_border_width         nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite draw_minimal_borders        nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite window_margin_width         nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite single_window_margin_width  nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite window_padding_width        nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite placement_strategy          nextgroup=kittyPlaceStrat
syn keyword kittyConfigItem skipwhite active_border_color         nextgroup=kittyColor,kittySpecialOpt
syn keyword kittyConfigItem skipwhite inactive_border_color bell_border_color nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite inactive_text_alpha         nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite hide_window_decorations     nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite resize_debounce_time        nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite resize_draw_strategy        nextgroup=kittyRDrawStrat

syn keyword kittyPlaceStrat contained center top-left
syn keyword kittyRDrawStrat contained static scale blank size

" Tab bar options {{{2
syn keyword kittyConfigItem skipwhite tab_bar_edge            nextgroup=kittyTabBarEdge
syn keyword kittyConfigItem skipwhite tab_bar_margin_width    nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite tab_bar_style           nextgroup=kittyTabBarStyl
syn keyword kittyConfigItem skipwhite tab_bar_min_tabs        nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite tab_switch_strategy     nextgroup=kittyTabSwitch
syn keyword kittyConfigItem skipwhite tab_fade                nextgroup=kittyNumberGrp
syn keyword kittyConfigItem skipwhite tab_separator           nextgroup=kittyString
syn keyword kittyConfigItem skipwhite tab_title_template      nextgroup=kittyString
syn keyword kittyConfigItem skipwhite active_tab_foreground   nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite active_tab_background   nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite active_tab_font_style   nextgroup=kittyString
syn keyword kittyConfigItem skipwhite inactive_tab_foreground nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite inactive_tab_background nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite inactive_tab_font_style nextgroup=kittyString

syn keyword kittyTabBarEdge contained top bottom
syn keyword kittyTabBarStyl contained fade separator hidden
syn keyword kittyTabSwitch  contained previous left last

" Color scheme settings {{{2
syn keyword kittyConfigItem skipwhite foreground background           nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite background_opacity              nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite dynamic_background_opacity      nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite dim_opacity                     nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite selection_foreground            nextgroup=kittyColor
syn keyword kittyConfigItem skipwhite selection_background            nextgroup=kittyColor

exe 'syn keyword kittyConfigItem skipwhite '.join(map(range(0, 255), '"color".v:val')).' nextgroup=kittyColor'
" The old version of this code was so fucking stupid what was i even thinking

" Advanced settings {{{2
syn keyword kittyConfigItem skipwhite shell editor          nextgroup=kittySpecialOpt,kittyCommand
syn keyword kittyConfigItem skipwhite close_on_child_death  nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite allow_remote_control  nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite update_check_interval nextgroup=kittyNumber
" TODO: startup_session
syn keyword kittyConfigItem skipwhite clipboard_control     nextgroup=kittyClipCtrl
syn keyword kittyConfigItem skipwhite term                  nextgroup=kittyString

syn keyword kittyClipCtrl   skipwhite contained no-append write-clipboard write-primary read-clipboard read-primary nextgroup=kittyClipCtrl

" OS-Specific settings {{{2
syn keyword kittyConfigItem skipwhite macos_titlebar_color                nextgroup=kittyMOSTBarCol,kittyColor
syn keyword kittyConfigItem skipwhite macos_option_as_alt                 nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite macos_hide_from_tasks               nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite macos_quit_when_last_window_closed  nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite macos_window_resizable              nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite macos_thicken_font                  nextgroup=kittyNumber
syn keyword kittyConfigItem skipwhite macos_traditional_fullscreen        nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite macos_show_window_title_in_menubar  nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite macos_custom_beam_cursor            nextgroup=kittyBoolean
syn keyword kittyConfigItem skipwhite linux_display_server                nextgroup=kittyLINDispSrv

syn keyword kittyMOSTBarCol contained system background
syn keyword kittyLINDispSrv contained auto x11 wayland

" Keyboard shortcuts settings {{{2
syn keyword kittyConfigItem skipwhite kitty_mod           nextgroup=kittyKeySeq
syn keyword kittyConfigItem skipwhite clear_all_shortcuts nextgroup=kittyBoolean

syn keyword kittyConfigItem skipwhite map                 nextgroup=kittyKeySeq

syn match   kittyKeySeq   skipwhite contained /\%([+>]\?\S\+[+>]\?\)\+/ contains=kittyKeyName nextgroup=kittyAction
syn keyword kittyKeyName  skipwhite contained alt backspace ctrl delete down enter escape equal home insert kitty_mod left minus page_down page_up right shift up
syn match   kittyKeyName  skipwhite contained /f\d\d\?/

syn match   kittyCmdPfx skipwhite contained /\%(@\|!neighbor\)/ nextgroup=kittyCommand
" Actions {{{2

" Piping {{{3
" TODO

" Kittens {{{3
" TODO: Finish this
syn keyword kittyAction skipwhite contained kitten nextgroup=kittyKitten
syn keyword kittyKitten skipwhite contained unicode_input
syn keyword kittyKitten skipwhite contained hints nextgroup=kittyKTNHints

" Hints {{{4
syn match   kittyKTNHints skipwhite contained /--type=\?/ nextgroup=kittyKTNH_typ
syn keyword kittyKTNH_typ skipwhite contained regex hash path url word line nextgroup=kittyKTNHints
syn match   kittyKTNHints skipwhite contained /--program=\?/ nextgroup=kittyKTNH_pro,kittyCommand
syn keyword kittyKTNH_pro skipwhite contained - nextgroup=kittyKTNHints

" Kitty shell {{{3
syn keyword kittyAction skipwhite contained kitty_shell nextgroup=kittySHView
syn keyword kittySHView contained window tab overlay os_window

" Combined actions {{{3
syn keyword kittyAction skipwhite contained combine nextgroup=kittyCombineAct

syn match kittyCombineAct transparent contained keepend /\%(:[^:]\+\)\+/ contains=kittySplitAct
syn keyword kittySplitAct skipwhite contained : nextgroup=kittyAction

" Clipboard {{{3
syn keyword kittyAction contained copy_to_clipboard paste_from_clipboard paste_from_selection paste_from_selection
syn keyword kittyAction skipwhite contained pass_selection_to_program nextgroup=@Sh

" Scrolling {{{3
syn keyword kittyAction contained scroll_line_up scroll_line_down scroll_page_up scroll_page_down scroll_home scroll_end show_scrollback

" Window management {{{3
syn keyword kittyAction skipwhite contained new_window new_window_with_cwd nextgroup=kittyCmdPfx,kittyCommand
syn keyword kittyAction contained new_os_window close_window next_window previous_window move_window_forward move_window_backward move_window_to_top start_resizing_window
syn match   kittyAction skipwhite contained /\%(first\|second\|third\|fourth\|fifth\|sixth\|seventh\|eighth\|ninth\|tenth\)_window/

" Tab management {{{3
syn keyword kittyAction skipwhite contained new_tab new_window_with_cwd nextgroup=kittyCmdPfx,kittyCommand
syn keyword kittyAction contained next_tab previous_tab close_tab move_tab_forward move_tab_backward set_tab_title
syn keyword kittyAction skipwhite contained goto_tab nextgroup=kittyNumber

" Layout management {{{3
syn keyword kittyAction contained next_layout last_used_layout
syn keyword kittyAction skipwhite contained goto_layout nextgroup=kittyLayout

" Font sizes {{{3
syn keyword kittyAction skipwhite contained change_font_size nextgroup=kittyFontChange
syn keyword kittyFontChange skipwhite contained all current nextgroup=kittyNumber

" Miscellaneous {{{3
syn keyword kittyAction contained toggle_fullscreen toggle_maximized edit_config_file
syn keyword kittyAction skipwhite contained set_background_opacity nextgroup=kittySpecialOpt,kittyNumber
syn keyword kittyAction skipwhite contained clear_terminal nextgroup=kittyClearMthd
syn keyword kittyAction skipwhite contained send_text nextgroup=kittyKBDModes

syn keyword kittyClearMthd skipwhite contained reset clear scrollback scroll nextgroup=kittyClearTrgt
syn keyword kittyClearTrgt contained active all
syn match   kittyKBDModes skipwhite keepend contained /\%(,\?\w\+,\?\)\+/ contains=kittyKBDMode nextgroup=kittyString
syn keyword kittyKBDMode  contained normal application kitty all

" Environment variables {{{2
syn keyword kittyConfigItem skipwhite env nextgroup=@Sh
" NOTE: This should probably be handled internally but I'm not doing that right now.

" Highlight settings {{{1
hi def link kittyComment    Comment
hi def link kittyBoolean    Boolean
hi def link kittyNumber     Number
hi def link kittyNumberGrp  Normal
hi def link kittyChar       Character
hi def link kittyCharGrp    Normal
hi def link kittyString     String
hi def link kittyColor      Special
hi def link kittyConfigItem Identifier
hi def link kittySpecialOpt Keyword
hi def link kittyCursrShape Keyword
hi def link kittyUrlStyle   Keyword
hi def link kittySTSOpts    Keyword
hi def link kittyPlaceStrat Keyword
hi def link kittyRDrawStrat Keyword
hi def link kittyTabBarEdge Keyword
hi def link kittyTabBarStyl Keyword
hi def link kittyTabSwitch  Keyword
hi def link kittyClipCtrl   Keyword
hi def link kittyMOSTBarCol Keyword
hi def link kittyLINDispSrv Keyword
hi def link kittyKeySeq     String
hi def link kittyKeyName    Constant
hi def link kittyAction     Function
hi def link kittyCmdPfx     PreProc
hi def link kittySpecialArg PreProc
hi def link kittyGlob       PreProc
hi def link kittyFontChange String
hi def link kittySHView     Keyword
hi def link kittyClearMthd  Function
hi def link kittyClearTrgt  Keyword
hi def link kittyKBDMode    Keyword
hi def link kittyHexEscape  SpecialChar
hi def link kittyUniEscape  SpecialChar
hi def link kittyKitten     Function
hi def link kittyKTNHints   Special
hi def link kittyKTNH_typ   Keyword
hi def link kittyKTNH_pro   PreProc
hi def link kittySplitAct   PreProc
hi def link kittyInclude    Include

" Cleanup {{1
let b:current_syntax = 'kitty'

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim:ft=vim:fdm=marker
