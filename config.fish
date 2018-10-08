if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

if not functions -q fisher
    echo "Installing fisher for the first time..." >&2
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fisher
end

set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $HOME/.multirust/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src $fish_user_paths
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden --glob "!.git/*"'
set -g -x EDITOR nvim
set -g -x CLICOLOR 1
set grc_wrap_commands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat pcommands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff
