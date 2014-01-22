# Ensure we search local first (OSX fail)
export PATH=~/.rbenv/shims:/usr/local/bin:${PATH}
# And remove any duplicate entries
typeset -U PATH

