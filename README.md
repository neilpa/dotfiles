# dotfiles

My simplified dotfiles.

WARNING - History has and may again be rewritten.


```sh
git clone git@github.com:neilpa/dotfiles.git ~/.config
path/to/dotfiles/bootstrap.sh
```

The `bootstrap.sh` script hardlinks files in `turds` to `~`, prefixing with a dot. Everything else _should_ work as-is assuming conformance to default XDG `~/.config` directory.

## shells

There are customizations in here for multiple shells. `.shrc` is the most portable and is sourced by Bash and zsh config.

Where possible, the shell config will attempt to force XDG compliance to limit hardlinks into `~`. For example, customizing `VIMINIT`.

