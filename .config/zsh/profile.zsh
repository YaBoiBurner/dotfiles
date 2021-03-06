if (( $+aliases[which] )) unalias which # There's a file fedora comes with that screws up the which builtin
if [[ "$XDG_CURRENT_DESKTOP" == gnome ]] xrdb -merge ~/.Xdefaults

for element ( "$HOME/bin" "$HOME/.dotnet/tools" ) path[${path[(i)$element]}]=()

if [[ "$options[interactive]" == off ]]; then
  typeset +x LESSOPEN
fi

if [[ "$MANPATH" = "/usr/share/lmod/lmod/share/man" ]]; then
  typeset +x MANPATH
fi

if [[ "$BASH_ENV" = "/usr/share/lmod/lmod/init/bash" ]]; then
  typeset +x BASH_ENV
fi

unset HISTCONTROL
unset HISTSIZE
# vim:ft=zsh fdm=marker
