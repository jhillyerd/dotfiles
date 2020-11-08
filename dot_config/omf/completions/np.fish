set -l project_dir $HOME/devel

# disable file completions
complete -c np -f
complete -c np -a "(__relative_complete_dir $project_dir/)"
