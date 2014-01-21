# Ensure we search local first (OSX fail)
export PATH=/usr/local/bin:${PATH}
# And remove any duplicate entries
typeset -U PATH

