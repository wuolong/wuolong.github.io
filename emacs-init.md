Emacs Configuration
====

Emacs 27 started to use the `~/.emacs.d` folder and `~/.emacs.d/init.el` config file instead of the old
`~/.emacs`. This approach reduces the clutter under the home directory and makes it easier to manage these files with
version control. I put mine in a private repository on GitHub.

# Early-Init 

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

# Minibuffer Completion

While others have pop-up windows or dialog boxes, Emacs has minibuffers. This is the usually one-line buffer at the bottom and it's the main way of interacting with Emacs without the use of Mouse (true Emacser has no use for that). These completion framework makes it easier to work within the minibuffer. 

- [vertico](https://github.com/minad/vertico): VERTical Interactive COmpletion, minimalistic vertical completion UI based on the default completion
  system.
- [orderless](https://github.com/oantolin/orderless): provides an orderless completion style that divides the pattern into space-separated components, and
  matches candidates that match all of the components in any order.
- [marginalia](https://github.com/minad/marginalia): enriches the completion display with annotations, e.g., documentation strings or file information
- [consult](https://github.com/minad/consult): provides search and navigation commands.
- [embark](https://github.com/oantolin/embark): offers context dependent actions.

```emacs-lisp
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))
(use-package savehist
  :init
  (savehist-mode))
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
(use-package consult
  :ensure t
  :bind (("C-x r b" . consult-bookmark))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (setq consult-narrow-key "<"))
(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))
(use-package marginalia
  :after vertico
  :ensure t
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
```
