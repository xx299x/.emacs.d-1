;;; elpa
;; ====================elpa=========================
(require 'package)
(unless package--initialized
  ;; 使用http://elpa.emacs-china.org镜像源。
  (setq package-archives '(("melpa" . "http://elpa.emacs-china.org/melpa/")
                           ("gnu" . "http://elpa.emacs-china.org/gnu/")
                           ("org" . "http://elpa.emacs-china.org/org/")
                           ("marmalade" . "http://elpa.emacs-china.org/marmalade/")))
  ;; 使用官方源。
  ;; (setq package-archives '(("melpa" . "http://melpa.org/packages/")
  ;;                          ("gnu" . "http://elpa.gnu.org/packages/")
  ;;                          ("org" . "http://orgmode.org/elpa/")
  ;;                          ("elpa" . "http://tromey.com/elpa/")
  ;;                          ("marmalade" . "http://marmalade-repo.org/packages/")))
  ;; Optimization, no need to activate all the packages so early.
  (setq package-enable-at-startup nil)
  ;; 激活所有packages，也可以使用package-activate单独激活。
  (package-initialize)
  ;; win中出现Failed to download `gnu' archive错误。
  (when is-win
    (setq package-check-signature nil)))
;; 借自prelude。
(defvar prelude-packages
  (append '(ace-jump-mode
            ace-link
            ace-pinyin
            ac-html-bootstrap
            ac-ispell
            ac-math
            aggressive-indent
            anchored-transpose
            anzu
            arduino-mode
            async
            auctex
            auctex-latexmk
            auto-complete
            auto-complete-auctex
            auto-complete-c-headers
            auto-complete-clang
            auto-highlight-symbol
            avy
            avy-zap
            backup-walker
            bbyac
            bind-key
            bing-dict
            bm
            buttercup
            cdlatex
            pyim
            pyim-basedict
            clean-aindent-mode
            clipmon
            company
            company-c-headers
            company-quickhelp
            company-try-hard
            company-web
            counsel
            dash
            diff-hl
            diminish
            dired-details
            dired-narrow
            dired-ranger
            diredful
            disaster
            drag-stuff
            dumb-jump
            firefox-controller
            function-args
            easy-kill
            ein
            elisp-slime-nav
            elmacro
            elpy
            emmet-mode
            emms
            epl
            eshell-prompt-extras
            evil-nerd-commenter
            expand-region
            f
            find-file-in-project
            flycheck
            flycheck-pos-tip
            git-commit
            git-timemachine
            gnuplot-mode
            god-mode
            google-translate
            goto-chg
            graphviz-dot-mode
            helm
            helm-ag
            helm-bibtex
            helm-bm
            helm-core
            helm-descbinds
            helm-firefox
            helm-flycheck
            helm-flyspell
            helm-gtags
            helm-projectile
            helm-swoop
            helm-unicode
            highlight-indentation
            highlight-parentheses
            highlight-symbol
            hungry-delete
            hydra
            imenu-anywhere
            interleave
            ivy
            ivy-hydra
            js2-mode
            lacarte
            latex-preview-pane
            let-alist
            magic-latex-buffer
            magit
            magit-popup
            markdown-mode
            math-symbol-lists
            matlab-mode
            multifiles
            multiple-cursors
            names
            navi-mode
            neotree
            nyan-mode
            operate-on-number
            outline-magic
            outorg
            outshine
            paredit
            paredit-everywhere
            parsebib
            peep-dired
            perspective
            persp-projectile
            pinyinlib
            pinyin-search
            pkg-info
            popup
            popup-kill-ring
            popwin
            pos-tip
            projectile
            pyvenv
            quickrun
            rainbow-delimiters
            rainbow-mode
            readline-complete
            recentf-ext
            rich-minority
            s
            session
            skewer-mode
            smart-mode-line
            smartrep
            smex
            swiper
            tangotango-theme
            undo-tree
            use-package
            vimish-fold
            visible-mark
            visual-regexp
            vlf
            volatile-highlights
            w3m
            web-mode
            which-key
            window-numbering
            with-editor
            wrap-region
            yasnippet
            youdao-dictionary
            zotelo
            ztree)
          (cond
           (is-lin '(fcitx
                     helm-mu
                     helm-pass
                     mu4e-alert
                     org
                     org-noter
                     pass
                     pdf-tools
                     sudo-edit
                     tablist
                     term-keys
                     yaml-mode
                     ycmd
                     company-ycmd
                     flycheck-ycmd))
           (is-win '(everything
                     w32-browser
                     mew
                     mingus))))
  "A list of packages to ensure are installed at launch.")
(defun prelude-packages-installed-p ()
  "Check if all packages in `prelude-packages' are installed."
  (cl-every #'package-installed-p prelude-packages))
(defun prelude-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package prelude-packages)
    (add-to-list 'prelude-packages package))
  (unless (package-installed-p package)
    (package-install package)))
(defun prelude-require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'prelude-require-package packages))
(defun prelude-install-packages ()
  "Install all packages listed in `prelude-packages'."
  (unless (prelude-packages-installed-p)
    ;; Check for new packages (package versions).
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; Install the missing packages.
    (prelude-require-packages prelude-packages)))
;; Run package installation.
(prelude-install-packages)
;; ====================elpa=========================
;;; USE-PACKAGE
;; =================USE-PACKAGE=====================
;; :bind或:commands中需使用package或:config中的函数。
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
;; =================USE-PACKAGE=====================
;;; smartrep
;; ===================smartrep======================
(use-package smartrep
  :config
  (setq smartrep-mode-line-string-activated nil)
  (smartrep-define-key global-map "<escape>"
    '(("i" . tab-to-tab-stop)
      ("u" . upcase-word)
      ("l" . downcase-word)
      ("c" . capitalize-word)
      ("q" . fill-paragraph)
      ("h" . mark-paragraph)
      ("k" . kill-sentence))))
;; ===================smartrep======================
;; =====================misc========================
(require 'subr-x)
(require 'bookmark)
;; =====================misc========================
(provide 'setup_elpa)
