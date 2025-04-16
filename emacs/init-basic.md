Emacs Configuration Basics
======

# Change Default Variables

Most of the time, use `setq` to change the values of variables:
```emacs-lisp
(setq kill-whole-line t           
      show-paren-style 'mixed
      use-dialog-box nil
      echo-keystrokes 2
      require-final-newline t
      backward-delete-char-untabify-method 'all
      column-number-mode t
      vc-follow-symlinks t
      delete-by-moving-to-trash t)
```

Some variables are automatically "buffer-local", meaning that every buffer can have a different value and `setq` only changes the value in the local buffer. To change the default for all buffers, use `setq-default`:
```emacs-lisp
(setq-default indent-tabs-mode nil
              tab-width 4
              fill-column 118)
```
