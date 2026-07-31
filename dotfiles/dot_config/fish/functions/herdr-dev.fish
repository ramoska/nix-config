function herdr-dev --description "Create 70/30 layout in current pane with nvim and dense claude"
    set -l top_pane_id (herdr pane list | jq -r '.result.panes[] | select(.focused == true) | .pane_id')

    set -l split_down (herdr pane split --direction down --ratio 0.7)
    set -l bottom_left_id (echo $split_down | jq -r '.result.pane.pane_id')

    herdr pane split --pane $bottom_left_id --direction right > /dev/null

    herdr pane run $top_pane_id nvim
    herdr pane run $bottom_left_id "dense claude"
end
