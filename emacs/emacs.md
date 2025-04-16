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

- [early-init.el](./early-init.md): this is loaded before the package system and GUI is initialized (step 6). 
- [Basics](./init-basic.md): the basics
- [Packages](./emacs-package.md): find, install and load packages
- [Keybindings](./emacs-keys.md): Emacs is all about using the keyboard (instead of mouse)
- [Minibuffer](./minibuffer.md): in lieu of annoying dialog windows

