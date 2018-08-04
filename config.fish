if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src $fish_user_paths
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden --glob "!.git/*"'
set -g -x EDITOR nvim
set -g -x CLICOLOR 1
set grc_wrap_commands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat pcommands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff
