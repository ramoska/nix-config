function rex-dev --description 'Split current Rex pane: nvim top 70%, claude bottom-left, shell bottom-right'
    if not set -q REX_SESSION; or not set -q REX_BLOCK
        echo "rex-dev: not inside a Rex terminal" >&2
        return 1
    end

    # Refuse to run in a tab that already has splits.
    set -l window (rex block inspect -s $REX_SESSION $REX_BLOCK --json | jq -er '.block.window_id')
    or return
    if test (rex block ls -s $REX_SESSION -w $window -q | count) -gt 1
        echo "rex-dev: current tab already has splits" >&2
        return 1
    end

    set -l cwd $PWD

    # Top 70%: editor. Current pane shrinks to bottom 30%.
    rex split -s $REX_SESSION -b $REX_BLOCK --split=above --ratio 70 --focus=false -c $cwd --label Editor -- nvim
    or return

    # Bottom row halved: claude on the left, current pane stays on the right.
    rex split -s $REX_SESSION -b $REX_BLOCK --split=left --ratio 50 --focus=false -c $cwd --label Claude -- claude
end
