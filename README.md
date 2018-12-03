# dotfiles

My simplified dotfiles. 


```sh
git clone https://github.com/neilpa/dotfiles ~/.config
~/.config/bootstrap.sh
```

The `bootstrap.sh` script hardlinks files in `_tilde` to `~`, prefixing with a
dot. Everything else _should_ work as-is assuming conformance to XDG config.

## shells

There customizations in here for multiple shells. `.shrc` is the most portable
and is sourced by Bash and zsh config.

Where possible, the shell config will attempt to force XDG compliance to limit
hardlinks into `~`. For example, customizing `VIMINIT`.
