#!/bin/sh

# Download and install (e.g, *.wasm files) and place them in ~/dotfiles/.config/zellij/plugins

# Array of plugin urls to install from. Must be raw wasm files.
declare -a plugins=(
    "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm"
)

# Use curl to download the plugins
download_plugin() {
    local plugin_url="$1"
    local plugin_name=$(basename "$plugin_url")
    local plugin_path="$HOME/dotfiles/.config/zellij/plugins/$plugin_name"
    
    echo "Processing $plugin_url"
    
    if [[ -f "$plugin_path" ]]; then
        local checksum=$(sha256sum "$plugin_path" | awk '{print $1}')
        local expected_checksum=$(curl -sL "$plugin_url" | sha256sum | awk '{print $1}')
        
        if [[ "$checksum" != "$expected_checksum" ]]; then
            echo "Plugin has been updated, downloading new version"
            curl -L "$plugin_url" -o "$plugin_path"
        else
            echo "Plugin is up to date, skipping download"
        fi
    else
        echo "Plugin not found, downloading"
        curl -L "$plugin_url" -o "$plugin_path"
    fi
}

# Process each plugin
for plugin in "${plugins[@]}"; do
    download_plugin "$plugin"
done

