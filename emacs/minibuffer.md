Minibuffer Completion
====

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

