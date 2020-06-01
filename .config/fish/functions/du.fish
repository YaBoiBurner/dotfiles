function du
  argparse --name=du --ignore-unknown 'h/help' 'J/json' -- $argv

  set -l cmd du

  if set -q _flag_h
    command $cmd --help $argv
    return
  else if set -q _flag_J && command -qs jc
    if isatty stdout && [ (command -s prettier tput bat | count) = 3 ]
      command $cmd $argv \
         | jc --du \
         | prettier --parser json --print-width (tput cols) \
         | bat --language=json --paging=never --color=always --style=plain
    else
      command $cmd $argv | jc --du
    end
  else
    if isatty stdout
      set -a cmd --human-readable --si
      command -qs grc && set -p cmd grc
    end
    command $cmd $argv
  end
end