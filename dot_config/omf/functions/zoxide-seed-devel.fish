function zoxide-seed-devel -d "Seed zoxide with new top-level dirs in ~/devel"
    set -l devel_dir $HOME/devel
    set -l stamp_file $HOME/.local/state/zoxide-seed-devel.stamp

    test -d "$devel_dir"; or return 0
    command -q zoxide; or return 0

    mkdir -p (path dirname $stamp_file)

    for dir in $devel_dir/*/
        if not test -f "$stamp_file"; or test "$dir" -nt "$stamp_file"
            zoxide add "$dir"
        end
    end

    touch "$stamp_file"
end
