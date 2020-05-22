# Makes vmstat(8) use KB instead of KiB
function vmstat
  set -l cmd vmstat
  if isatty stdout
    set -a cmd --unit k
    command -qs grc && set -p cmd grc
  end
  command $cmd $argv
end
