---
title: Emacs 
---

# Installation

- [Emacs For Mac OS X](https://emacsformacosx.com): vanilla build (preferred on mac)
- [GNU Emacs Windows Built](https://gnu.mirror.constant.com/emacs/windows/)
- [Emacs Modified for (macOS|Windows)](https://emacs-modified.gitlab.io): bundled with a few packages (preffered on Windows)
- [Homebrew Emacs Plus (macOS)](https://github.com/d12frosted/homebrew-emacs-plus)

# Configuration

Emacs 27 started to use the `~/.emacs.d` folder and `~/.emacs.d/init.el` init file instead of the old dotemacs
(`~/.emacs`) for configurations. This approach reduces the clutter under the home directory and makes it easier to
manage these files with version control. See [Emacs startup sequences](https://www.gnu.org/software/emacs/manual/html_node/elisp/Startup-Summary.html) for a list of steps during startup.

- [early-init.el](./early-init.md): Step 6, before the package system and GUI is initialized. The full init file is loaded as Step
  14.
- [Minibuffer](./minibuffer.md)

# Keybinding Reference

| Group     | Key     | Function                                                | Custom |
|-----------|---------|---------------------------------------------------------|--------|
| Bookmarks | C-x x m | Bookmark the file (bmkp-bookmark-set-confirm-overwrite) |        |
|           | C-x j j | Jump to a bookmark (bookmark-jump)                      |        |
|           | C-x r l | List/edit boomarks (bookmark-bmenu-list)                |        |
|           | C-x r b | Jump to bookmark or create a new one (consult-bookmark) |        |
|-----------|---------|---------------------------------------------------------|--------|
| URL       | C-c .   | browse-url-at-point                                     | X      |
| Dired     | C-x C-q | Edit file names directly (dired-toggle-read-only)       |        |
|           |         |                                                         |        |
