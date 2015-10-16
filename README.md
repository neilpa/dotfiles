Started as a fork of [Zach Holman's dotfiles](https://github.com/holman/dotfiles) which was itself a fork of [Ryan Bate's dotfiles](http://github.com/ryanb/dotfiles). Things are still in flux and I expect more changes. (TODO Better description of the dotfiles than the cursory update that's been done).

## install

Run this:

```sh
cd ~/
git clone https://github.com/neilpa/dotfiles.git .config
cd .config/
./bootstrap
```

This will symlink the appropriate files in `~/.config` to your home directory.
Everything is configured and tweaked within `~/.config`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## topical

Everything's built around topic areas. If you're adding a new area to your
dotfiles — say, "Java" — you can simply add a `java` directory and put files
in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `bootstrap`.
