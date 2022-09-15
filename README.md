# dotfiles

My simplified dotfiles.

WARNING - History has and may again be rewritten.


```sh
git clone git@github.com:neilpa/dotfiles.git ~/.config
~/.config/bootstrap.sh
```
The `bootstrap.sh` script symlinks files in `_home` and `_$(uname -s)` directories `` to `~`, prefixing with a dot. Everything else _should_ work as-is assuming conformance to default XDG `~/.config` directory.

## shells

There are customizations in here for multiple shells. `.shrc` is the most portable and sourced by Bash and zsh config.

Where possible, the shell config will attempt to force XDG compliance to limit links into `~`. For example, customizing `VIMINIT`.

