complete -c stdbuf -xa "(__fish_complete_subcommand)"
complete -c stdbuf -x -s i -l input -d "Adjust standard input stream buffering"
complete -c stdbuf -x -s o -l output -d "Adjust standard output stream buffering"
complete -c stdbuf -x -s e -l error -d "Adjust standard error stream buffering"
complete -c stdbuf -l help -d "Display help & exit"
complete -c stdbuf -l version -d "Display version & exit"
