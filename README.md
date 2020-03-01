# dotfiles

My simplified dotfiles. 


```sh
git clone https://github.com/neilpa/dotfiles path/to/dotfiles
path/to/dotfiles/bootstrap.sh
```

The `bootstrap.sh` script hardlinks files in `turds` to `~`, prefixing with a
dot. ~~Everything else _should_ work as-is assuming conformance to XDG config.~~

No longer assuming this is checked out at `.~/.config`. Top level directories
sans `turds` are symlinked into `~` (e.g. `bin`) or `~/.config` (e.g. `git`, `vim`)
as appropriate. This update is due to linux distros having pre-installed a bunch
of packages that have already written settings into `~/config`. This makes cloning
dotfiles directly into `~/.config` and merging existing settings tricky. Easier
to just link in settings as needed.

## shells

There are customizations in here for multiple shells. `.shrc` is the most portable
and is sourced by Bash and zsh config.

Where possible, the shell config will attempt to force XDG compliance to limit
hardlinks into `~`. For example, customizing `VIMINIT`.
