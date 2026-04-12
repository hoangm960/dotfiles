# source ~/.local/share/omarchy/default/bash/rc

# opencode
export PATH=/home/meng/.opencode/bin:$PATH
export EDITOR=nvim
export TERMINAL=kitty

is_niri_running() {
    if pgrep -x "niri" > /dev/null; then
        return 0
    else
        return 1
    fi
}

if is_niri_running; then
    exec fish
else
    echo "Niri not detected. Continuing with bash shell."
fi

export PATH=$PATH:/home/meng/.spicetify
export PATH=$JAVA_HOME/bin:$PATH
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

. "$HOME/.local/bin/env"
