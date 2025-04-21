Emacs Packages
====

# Package.el

Emacs's power lies in its infinite extensibility which involves the use of contributed "packages". `package.el` has become part of Emacs to make the process much easier.

Out of the box, GNU [ELPA](https://www.emacswiki.org/emacs/ELPA) (Emacs Lisp Package Archive) is the default repository. [MELPA](https://melpa.org/#/getting-started) has more bleeding edge
stuff.

```emacs-lisp
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
```

# Quick Reference

- Use `M-x list-packages` (or `package-list-package` which is just an alias) to see list the available packages.
  - `/ n` to filter by name
  - `/ /` to unfilter
  - `i` to make a package for installation
  - `x` to execute marked actions.
- `M-x package-install` to install a package.
- `M-x package-upgrade-all` to upgrade all packages.
- `M-x package-autoremove` to delete obsoleted packages. I found that this is not entirely reliable and sometimes
  removes package still needed.

All installed packages are automatically added to the custom-set variable `package-selected-packages`.

# Use-Package

[use-package](https://github.com/jwiegley/use-package) is a macro (distributed with Emacs since version 30) to set up package customization. 

- `:ensure` install a package if not present.
- `:if` conditional loading
- `:defer t` do not load immediately but wait until trigger by auto-load functions defined in the package.
- `:after` load after other packages
- `:require` pre-requisite package.
- `:bind` binds keys either globally or package-defined keymaps.
- `:hook` adds functions to hooks.
- `:mode` updates `auto-mode-alist`
- `:init` executes code **before** loading package
- `:config` executes code **after** loading package

When MacOS starts GUI Emacs, it does not inherit the environment variables `PATH` from the shell configuration so we need fix this.
```emacs-lisp
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))
```
