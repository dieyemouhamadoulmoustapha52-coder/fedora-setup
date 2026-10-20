echo "07- VS Code Extensions"

if command -v code &>/dev/null && [[ -f "$ICI/lists/vscode-extensions.list" ]]; then
    installed_exts=$(code --list-extensions)
    while read -r ext; do
        [[ -z "$ext" ]] && continue
        if ! echo "$installed_exts" | grep -qi "$ext"; then
            echo -n "  + Extension VS Code $ext : "
            run code --install-extension "$ext" --force
        fi
    done < "$ICI/lists/vscode-extensions.list"
fi
