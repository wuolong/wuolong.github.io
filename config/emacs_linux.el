;;; emacs.el ---
;; Time-stamp: "Thu Jun 25 17:20:01 EDT 2020 (nali@saruman)"
;; Revamped init file for Emacs Modified for MacOS, Jun 7, 2020
;; https://vigou3.gitlab.io/emacs-modified-macos/
;; to simplify and clean-up

;;; ===== Notes =====
;; chunks are separated by a blank line so one can jump up and down using
;; <C-up> forward-paragraph and <C-down> backward-paragraph

;;; ===== Emacs Packages =====
;; https://www.emacswiki.org/emacs/InstallingPackages
;; M-x package-install RET auctex RET
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") ; stable
             ;; '("melpa" . "http://melpa.org/packages/") ; cutting edge
             t)
(package-initialize)
(eval-when-compile
  (require 'use-package))               ; installed via elpa
;; this is the directory for personal lisp files
;; template.el, smart-compile.el, folding.el, fold-dwim.el
;; rsz-mini.el, tempbuf.el, dired+.el, w32-brower.el
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/lisp"))
(setq is-ms-windows (string-equal system-type "windows-nt")
      is-macos      (string-equal system-type "darwin")
      is-linux      (string-equal system-type "gnu/linux"))

;;; ===== use-package =====
;; a neat way of organizing package-related configuration
;; https://github.com/jwiegley/use-package

;;; ====== Appearances ========
;; frame title includes Emacs version, host and file full path.
(defconst host-name
  (car (split-string (shell-command-to-string "hostname") "\\.")))
(setq frame-title-format
      (concat "Emacs "
	      emacs-version " " (user-login-name) "@" host-name ": %f")
      icon-title-format "%b")
;; default window size and fonts
(setq default-frame-alist
      '((top . 10)
	(left . 650)
	(internal-border-width . 1)
	(width . 120)
	(height . 53)
	))
;; make the initial frame to appear in the left
(setq initial-frame-alist 
      '((left . 10)
	))
(setq inhibit-startup-message t		; Disable starting messages
      initial-scratch-message nil
      kill-whole-line t			; when kill a line, remove the newline as well
      show-paren-style 'mixed		; 'parenthesis or 'expression as needed
      )
(setq-default indent-tabs-mode nil
              fill-column 85)
(tool-bar-mode -1)                      ; turn off tool bar
(set-scroll-bar-mode nil)               ; turn off scroll bar
(menu-bar-enable-clipboard)
(display-time)                          ; show time

;; ======= Basic behavoir ==========================
;;
;; Make `C-x C-v' undefined so it can be used as prefix.
(global-unset-key (kbd "C-x C-v"))
;; C-z is pretty useless, let's use it as a modifier
(global-unset-key (kbd "C-z"))
(setq dired-use-ls-dired nil                 ;; ls does not support --dired option
      use-dialog-box nil
      echo-keystrokes 2
      require-final-newline t
      backward-delete-char-untabify-method 'all
      column-number-mode t		; show column number of where the cursor is
      vc-follow-symlinks t
      )
(setq backup-directory-alist '(("." . "~/tmp/backups")))

;;; match paren key
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "%") 'match-paren)

;;; ===== recent files =====
;; https://www.emacswiki.org/emacs/RecentFiles
(recentf-mode t)
(setq recentf-max-menu-items 20         ; default 10
      recentf-max-saved-items 40)       ; default 20

;;; ===== dired ======
;;; https://www.emacswiki.org/emacs/DiredPlus
;;; https://www.emacswiki.org/emacs/DiredMode
(require 'dired-x)
(setq diredp-hide-details-initially-flag nil)
;; (require 'dired+)
;; (add-hook 'dired-load-hook
;;           '(lambda ()
;;              (setq dired-x-hands-off-my-keys nil)
;;              ;; Make sure our binding preference is invoked.
;;              (setq dired-use-ls-dired nil)
;;              (dired-x-bind-find-file)))
;; (setq dired-omit-files
;;       (concat "^\\.\\(#\\|\\.\\|_\\)"
;;               "\\|^#"
;;               "\\|^\\(auto\\|CVS\\|TAGS\\|{arch}\\)/$"
;;               "\\|^\\.\\(\\svn\\|arch-ids\\|cvsignore\\|dired\\|DS_Store\\)$"))
(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".exe" ".obj" ".dll" ".dylib" ".snm" ".head" ".pdfsync" ".aux"
                ".RData" ".tmp" ".mp" ".tui" ".tuo" ".top" ".lot" ".lof" ".toc")))

;;; ====== system specific stuff =====
(cond (is-ms-windows
       (setq TeX-view-program-selection   '((output-pdf "SumatraPDF"))
             TeX-view-program-list        '(("SumatraPDF" "SumatraPDF %o")))
       )
      (is-macos
       (defun dired-open-mac ()
         "open file using MacOS default apps via `open'"
         (interactive)
         (let ((file-name (dired-get-file-for-visit)))
           (if (file-exists-p file-name)
               (shell-command (concat "open \"" file-name "\"" nil )))))
       (defun dired-do-trash ()
         "Move files to `trash' (homebrew) rather than delete outright"
         (interactive)
         (let ((file-name (dired-get-file-for-visit)))
           (if (file-exists-p file-name)
               (progn 
                 (shell-command (concat "trash " file-name nil))
                 (dired-update-file-line nil)))))
       (define-key dired-mode-map "o" 'dired-open-mac)
       (define-key dired-mode-map "\\" 'dired-do-trash) ; shortcut is one \
       (setq mac-command-modifier 'meta             ;; default is Super
             mac-option-modifier 'hyper             ;; default is Meta
             TeX-view-program-selection   '((output-pdf "Skim"))
             TeX-view-program-list        '(("Skim" "open -a Skim.app %o"))
             dired-guess-shell-alist-user '(("\\.pdf$" "open -a Skim.app")))
       )
      )

;; ===== ido (interactively do things) =====
;; remap `find-file` and 'switch-to-buffer' families of bindings with powered versions,
;; with completion engine matches anywhere in a name
;; https://www.emacswiki.org/emacs/InteractivelyDoThings
(setq ido-enable-flex-matching t)
(ido-mode t)
;; the order in which files are sorted
(setq ido-file-extensions-order '(".Rmd" ".tex" ".R" ".sas"))
(setq ido-ignore-directories
      (append ido-ignore-directories '("\\`auto/" "\\`{arch}/")))
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
;; C-x C-r was bound to ido-find-file-read-only
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;;; ===== spell checking =====
;; ignore code chunks when spelling check
(setq ispell-dictionary "en_US")
(add-to-list 'ispell-skip-region-alist '("^```" . "```$"))
;; https://www.emacswiki.org/emacs/InteractiveSpell
;; On-the-fly spell checking
;; https://www.emacswiki.org/emacs/FlySpell
(add-hook 'text-mode-hook 'flyspell-mode)
(global-set-key (kbd "<f9>") 'ispell-buffer)

;;; ===== comint =====
;; command-interpreter-in-a-buffer
;; https://www.emacswiki.org/emacs/ComintMode
(setq comint-scroll-to-bottom-on-input t
      comint-process-echoes t)
;; strip ^M when saving
(add-hook 'comint-output-filter-functions
	  'comint-strip-ctrl-m)
;; In comint modes the [up] and [down] keys will be mapped to this
;; two functions and will use the history only when the point is at
;; the command line.  In any other place the [up] and [down] keys
;; will behave as usual, i.e. move the point to the previous or next
;; line.  Smart, eh?  Tudor Hulubei
(defun smart-comint-up ()
  "Implement the behaviour of the up arrow key in comint mode.  At
the end of buffer, do comint-previous-input, otherwise just move in
the buffer."
  (interactive)
  (let ((previous-region-status
         (if (featurep 'xemacs) (region-active-p) nil)))
    (if (= (point) (point-max))
	(comint-previous-input 1)
      (previous-line 1))
    (when previous-region-status
      (activate-region))))
(defun smart-comint-down ()
  "Implement the behaviour of the down arrow key in comint mode.  At
the end of buffer, do comint-next-input, otherwise just move in the
buffer."
  (interactive)
  (let ((previous-region-status
         (if (featurep 'xemacs) (region-active-p) nil)))
    (if (= (point) (point-max))
	(comint-next-input 1)
      (forward-line 1))
    (when previous-region-status
      (activate-region))))
;; (define-key comint-mode-map [up]   'smart-comint-up)
;; (define-key comint-mode-map [down] 'smart-comint-down)

;; ===== time-stamp ======
;; If "Time-stamp: <>" or "Time-stamp " "" exist within the first
;; 8 lines i a file when saving, it will be written back like this
;; "Time-stamp: <'Date' 'Time' 'user'>"
(add-hook 'write-file-hooks 'time-stamp)
;; Use ISO 8601 date format, new style format string
(setq time-stamp-format
      (concat "%3a %3b %02d %02H:%02M:%02S %Z %:y (%u@%s)"))

;;; ====== minibuffer =======
;; https://www.emacswiki.org/emacs/MiniBuffer
;; resize-minibuffer-mode makes the minibuffer automatically
;; resize as necessary when it's too big to hold its contents.
;; http://web.mit.edu/dosathena/sandbox/emacs-19.28/lisp/rsz-mini.el
(autoload 'resize-minibuffer-mode "rsz-mini" nil t)
(setq resize-minibuffer-window-exactly nil)

;;; ===== auto-complete ======
;; https://github.com/auto-complete/auto-complete/blob/master/doc/manual.md
(ac-config-default)
;; user directionaries
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-dictionary-files '("~/.emacs.d/ac-dict/dict"))

;;; ====== folding ======
;; https://www.emacswiki.org/emacs/FoldingMode
;; (use-package folding
;;   :init
;;   (setq folding-default-keys-function 'folding-bind-outline-compatible-keys)
;;   :config
;;   (folding-mode-add-find-file-hook)
;;   (folding-add-to-marks-list 'ess-mode "### {{{ " "### }}}"))

;;; ====== bookmark ======
;; https://github.com/joodland/bm
(use-package bm
  :ensure t
  :bind
  (("<f2>"     . bm-next)
   ("M-<f2>"   . bm-toggle)   
   ("H-<f2>"   . bm-previous))
  :config
  ;; Allow cross-buffer 'next'
  (setq bm-cycle-all-buffers t))

;;; ===== hideshow =====
;; https://www.emacswiki.org/emacs/HideShow
(defun toggle-selective-display (column)
      (interactive "P")
      (set-selective-display
       (or column
           (unless selective-display
             (1+ (current-column))))))
(defun toggle-hiding (column)
      (interactive "P")
      (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))
(use-package hideshow
  :hook
  ((emacs-lisp-mode . hs-minor-mode)
   (c-mode-common . hs-minor-mode))
  :init
  (setq hs-hide-comments-when-hiding-all nil
        hs-isearch-open 't)
  :bind
  (("C-c h" . toggle-hiding)
   ("C-c s" . toggle-selective-display)))

;;; ===== yet another template system =====
;; http://joaotavora.github.io/yasnippet/
(use-package yasnippet
  :config
  (yas-global-mode 1))
;; markdown: code, img, link, rimg, rlb, rlink
;; latex: begin

;;; ===== template =====
;; http://emacs-template.sourceforge.net
;; (require 'template)
;; (setq template-default-directories '("~/.emacs.d/templates")
;;       ;; template-auto-insert t
;;       template-use-package t
;;       template-max-column 76)
;; (template-initialize)
;; ;; C-c t -> template-new-file
;; (global-set-key  (kbd "C-z t") 'template-insert-time)

;;; ===== basic key bindings =====
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "M-n") 'other-window)
(global-set-key (kbd "C-x f") 'ido-recentf-open) ; was bound to set-fill-column
(global-set-key (kbd "C-x c") 'count-words-region)
(global-set-key (kbd "C-c d") 'diary)   ; ~/.emacs.d/diary
(global-set-key (kbd "C-x w") 'what-line)
(global-set-key (kbd "C-x j") 'join-line)
(global-set-key (kbd "C-x o") 'occur)        ; shows all lines matching a regexp
(global-set-key (kbd "C-x C-j") 'dired-jump) ; jump to the dired buffer for current buffer
(global-set-key (kbd "C-x 4 C-j") 'dired-jump-other-window) ; use a different window
(global-set-key (kbd "C-c l") 'calculator)                  ; simple calculator
(global-set-key (kbd "C-c C-l") 'calc)                      ; fancy calculator
(global-set-key (kbd "C-c M-l") 'calc-dispatch)
(global-set-key (kbd "C-c c") 'calendar)
(global-set-key (kbd "C-c .") 'browse-url-at-point)
;;Replace all freakin' ^M chars in the current buffer
(fset 'replace-ctrlms
   [escape ?< escape ?% ?\C-q ?\C-m return ?\C-q ?\C-j return ?!])
(global-set-key (kbd "C-c m") 'replace-ctrlms)

;;; ===== Magit =====
(global-set-key (kbd "C-x g") 'magit-status)

;;; ===== smart folding - do what i mean =====
;; https://www.emacswiki.org/emacs/FoldDwim
(use-package fold-dwim
  :bind
  (("<f7>"     . fold-dwim-toggle)
   ("M-<f7>"   . fold-dwim-hide-all)
   ("M-S-<f7>" . fold-dwim-show-all)))

;;; ===== pcomplete =====
(use-package pcomplete
  :hook
  (shell-mode . pcomplete-shell-setup))

;;; ===== ELPY Emacs Python Development Environment =====
;;; https://elpy.readthedocs.io/en/latest/index.html
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  ;; use system python3 installed via homebrew in /usr/local/bin
  ;; a few python packages are helpful but not required, install with pip3
  ;; jedi - autocompletion tool
  ;; flake8 - source code syntax checker
  ;; black - code formatter
  ;; autopep8 - another code formatter to PEP8 style
  ;; yapf - yet another python formatter
  (setq elpy-rpc-virtualenv-path 'current
        elpy-rpc-python-command "/usr/local/bin/python3")
  ;; interactive python shell
  ;; C-c C-z : elpy-shell-switch-to-shell
  ;; C-c C-k : elpy-shell-kill
  ;; in a python file, commands are prefixed with C-c C-y
  ;; C-RET   or C-c C-y C-e   : elpy-shell-send-statement-and-step
  ;; C-c C-c or C-c C-y r     : elpy-shell-send-region-or-buffer
  ;; C-c C-y O                : elpy-shell-send-group-and-step
  ;; use python-mode
  (setq python-shell-interpreter "/usr/local/bin/python3"
        python-shell-interpreter-args "-i")
  ;; use jupyter
  ;; (setq python-shell-interpreter "jupyter"
  ;;       python-shell-interpreter-args "console --simple-prompt"
  ;;       python-shell-prompt-detect-failure-warning nil)
  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters
  ;;              "jupyter")
  :bind
  ("C-c C-z" . elpy-shell-switch-to-shell)
  )

;;; ===== EIN -- Emacs IPython Notebook =====
;; http://tkf.github.io/emacs-ipython-notebook/
;; http://ipython.org/ipython-doc/stable/notebook/index.html
;; install ipython via pip
;; M-x ein:notebooklist-open
;; supports python, julia and R kernels
;; (use-package ein
;;   :ensure t)

;;; ===== lua =====
(use-package lua-mode
  :ensure t)

;;; ===== tempbuf =====
;;; enables buffers to get automatically deleted in the background
;;; https://www.emacswiki.org/emacs/TempbufMode
;; (use-package tempbuf)

;;; ===== ESS (Emacs Speaks Statistics) =====
;;; http://ess.r-project.org
;;; Part of Emacs for MacOSX
(use-package ess-site
  :hook
  ((ess-mode . (lambda ()
                 (ess-set-style 'C++)
                 (setq ess-indent-level 4)))
   (ess-help-mode . turn-on-tempbuf-mode))
  :config
  (add-to-list 'auto-mode-alist '("\\.log\\'"  . sas-log-mode))
  (add-to-list 'auto-mode-alist '("\\.lst\\'"  . sas-listing-mode))
  :bind
  (:map ess-mode-map
        ("C-c C-k" . ess-eval-chunk)
        ("C-c M-k" . ess-eval-chunk-and-go))
  )

;;; ===== AucTeX (LaTeX) =====
(use-package tex-site
  :init
  (setq-default TeX-master nil
                TeX-PDF-mode t)
  :hook
  (LaTeX-mode . turn-on-reftex))
(setq reftex-plug-into-AUCTeX t)
(setq TeX-save-query nil
      TeX-auto-save t
      TeX-parse-self t
      TeX-show-compilation t
      LaTeX-math-menu-unicode t
      LaTeX-top-caption-list '("table")
      TeX-electric-sub-and-superscript t
      )
(add-hook 'LaTeX-mode-hook   
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t
                           :help "Run XeLaTeX"))))

;;; ===== Stan Mode ======
(use-package stan-mode
  :ensure t)
(use-package stan-snippets
  :ensure t)

;;; ===== Lua =====
;; (use-package lua-mode)

;;; ===== Polymode with Markdown =====
;; https://github.com/jrblevin/markdown-mode
;; https://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("\\.md\\'" . gfm-mode))
  :init (setq markdown-command "multimarkdown"))
(use-package poly-markdown
  :ensure t)
(use-package poly-R
  :ensure t)
(add-hook 'polymode-init-host-hook 'visual-line-mode 1)
(setq markdown-asymmetric-header t
      markdown-list-indent-width 2
      markdown-command "pandoc --mathjax -s --highlight-style tango")

;;; ===== julia =====
;; supported in ess
(cond (is-ms-windows
       (setq inferior-julia-program-name
             "C://Users/lim/Programs/Julia-1.2.1/bin/julia.exe"))
      (t))
(add-to-list 'polymode-mode-name-override-alist '(julia . ess-julia))

;;; ===== imenu =====
(global-set-key (kbd "<f3>") 'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t
      imenu-list-size 25
      imenu-list-auto-resize nil)
;; package "imenu-anywhere"
(global-set-key (kbd "C-.") 'ido-imenu-anywhere)

;;; ===== smart-compile =====
;; https://github.com/zenitani/elisp/blob/master/smart-compile.el
;; (require 'smart-compile)
;; (global-set-key (kbd "<f8>") 'smart-compile)
;; (add-to-list 'smart-compile-alist
;;              '("\\.[rR]md\\'" . "Rscript -e \"rmarkdown::render('%f')\""))
;; (add-to-list 'smart-compile-alist
;;              '("\\.[jJ]md\\'" . "julia -e 'using Weave; weave(\"%f\")'"))
;; (add-to-list 'smart-compile-alist
;;              '("\\.md\\'" . "pandoc -t latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash+yaml_metadata_block --template simple_latex.tex --highlight-style tango --variable graphics=yes -o %n.pdf %f"))

;;; ======= custom.el ===============================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wheatgrass)))
 '(package-selected-packages
   (quote
    (ess-smart-equals ess-smart-underscore lua-mode julia-repl-vterm bm fixmee jedi jedi-core py-autopep8 py-yapf python-black python-mode elpy yasnippet-snippets yasnippet-classic-snippets xcode-project use-package stan-snippets rust-playground rust-mode poly-ruby poly-rst poly-org poly-R magit jupyter julia-mode imenu-list imenu-anywhere ein)))
 '(safe-local-variable-values
   (quote
    ((encoding . gb2312)
     (reftex-cite-format . natbib)
     (TeX-auto-save)
     (TeX-auto-parse-length . 99999)
     (dired-actual-switches . "-lat")
     (dired-omit-mode . t)
     (folded-file . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 158 :width normal))))
 '(markdown-code-face ((t (:inherit fixed-pitch :foreground "linen"))))
 '(markdown-language-info-face ((t (:inherit font-lock-string-face :foreground "orange1")))))
