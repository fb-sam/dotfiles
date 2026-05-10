# dotfiles

Personal config for zsh (oh-my-zsh), starship, tmux (catppuccin), nvim, plus a couple of extras (`.bash_aliases`, `.ideavimrc`).

Used to keep a personal Mac and a work Mac in sync. Source of truth is this repo; `$HOME` files are symlinks pointing into the cloned working copy, so edits flow back automatically.

## What's tracked

```
.zshrc
.zprofile
.bash_aliases
.ideavimrc
.config/starship.toml
.config/tmux/tmux.conf
.config/nvim/                 ← whole tree, including lazy-lock.json
```

## What's NOT tracked

- `~/.oh-my-zsh/` — installed separately (see bootstrap below).
- `~/.config/tmux/plugins/` — `install.sh` re-clones [catppuccin/tmux](https://github.com/catppuccin/tmux) at v2.1.3.
- Nvim plugin install dirs (`~/.local/share/nvim`, `~/.local/state/nvim`) — lazy.nvim repopulates them from `lazy-lock.json` on first launch.

## Bootstrap a new machine

```bash
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Tools
brew install starship tmux neovim git
brew install --cask font-jetbrains-mono-nerd-font   # Nerd Font for tmux/starship glyphs

# 3. oh-my-zsh
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
# (it backs up the default .zshrc; the install step below replaces it with our symlink)

# 4. This repo
git clone git@github.com:fb-sam/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --dry-run    # preview every change
./install.sh              # do it
```

Open a fresh terminal — starship prompt, tmux macchiato theme, and nvim should all light up.

## install.sh

```
Usage: install.sh [OPTIONS]
  --dotfiles=PATH   Source repo path (default: directory containing this script)
  --target=PATH     Install destination (default: $HOME)
  --backup=PATH     Backup directory (default: <target>/.dotfiles-backup/<timestamp>)
  --dry-run         Show what would happen, change nothing
  --no-tmux-plugins Skip cloning catppuccin tmux
  -h, --help        Show usage
```

The script is idempotent — re-running on an already-installed machine reports `ok: already linked` for each path.

### Backup & rollback

Every run snapshots existing target files into `<backup>/` (default `$HOME/.dotfiles-backup/<timestamp>/`) **before** any changes, then writes a `restore.sh` into that same dir. To undo a run:

```bash
~/.dotfiles-backup/<timestamp>/restore.sh
```

`restore.sh` is conservative: it only removes symlinks that still point exactly where this run set them, and refuses to overwrite anything you've put back manually.

## Notes

- `.zprofile` hard-codes the Apple Silicon brew path (`/opt/homebrew/bin/brew`). On Intel Macs, change it to `/usr/local/bin/brew` or symlink a different file.
- The catppuccin tmux plugin is pinned to **v2.1.3** in `install.sh` — the v2.x options used in `.config/tmux/tmux.conf` (e.g. `@catppuccin_flavor`, `@thm_*` colors) won't match a future major version.
- nvim is configured via lazy.nvim; `lazy-lock.json` is committed so plugin versions reproduce exactly.
