Early-Init File
====

The `~/.emacs.d/early-init.el` is executed before the package system and GUI is initiated. 

First, set up a custom frame title, including emacs version, user and host names.
```emacs-lisp
(defconst host-name
  (car (split-string (shell-command-to-string "hostname") "\\.")))
(setq frame-title-format
      (concat "Emacs " emacs-version " " (user-login-name) "@" host-name ": %f")
      icon-title-format "%b")
```

Next, set default window size and font, which depends on what's available and the size can be adjusted to fit the screen. Also makes the initial frame to appear to the left, and new frame to the right.
```emacs-lisp
(setq default-frame-alist
      '((top . 10)
	    (left . 650)
	    (internal-border-width . 1)
	    (width . 120)
	    (height . 55)                   ; adjust for screen size
        (font . "Source Code Pro-14")   ; preferred on Mac
        ;; (font . "Consolas-14")
        ;; (font . "Courier-14")
        ;; (font . "Fira Code-14")
        ;; (font . "Lucida Console-14")
        ;; (font . "Lucida Sans Typewriter-11")
        ))
(setq initial-frame-alist
      '((left . 10)))
```

Disable startup messages, the toolbar and scroll bar:
```emacs-lisp
(setq inhibit-startup-message t	
      initial-scratch-message nil)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
```

Finally, set the custom file,
```emacs-lisp
(setq custom-file "~/.emacs.d/emacs-cus.el")
(load custom-file)
```

The rest of the stuff should go in `~/.emacs.d/init.el`.
