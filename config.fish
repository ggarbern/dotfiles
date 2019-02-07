if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

if not functions -q fisher
    echo "Installing fisher for the first time..." >&2
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fisher
end

set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $HOME/.multirust/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src $fish_user_paths
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden --glob "!.git/*"'
set -g -x EDITOR code
set -g -x CLICOLOR 1
set grc_wrap_commands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat pcommands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff

set -U FZF_LEGACY_KEYBINDINGS 0

# set SPACEFISH_PROMPT_ADD_NEWLINE false
# set SPACEFISH_PROMPT_SEPARATE_LINE false
# set SPACEFISH_USER_SHOW always
set SPACEFISH_RUST_SYMBOL '🦀 '
set SPACEFISH_RUST_VERBOSE_VERSION true

# ls
alias ls="exa"
alias la="exa -la"
alias ll="exa -l"
alias lll="exa -l | less"
alias lt="exa -T"
alias lty="exa -ls=extension"
alias llt="exa -lT"
alias lg="exa -bghHliS --git"

# rg
alias rgs="rg -S"
alias rgh="rg -uuS"
