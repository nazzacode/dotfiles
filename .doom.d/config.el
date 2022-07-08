(setq initial-major-mode 'org-mode)

(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")

;; Dark
;; (setq doom-theme 'my-doom-dark+)
(setq doom-theme 'doom-one)
;; (setq doom-theme 'my-doom-gruvbox)
;; Light
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'modus-operandi)

(setq-default line-spacing 0.15
              word-wrap t)
(setq display-line-numbers-type t          ; 'relative  ; or `nil'
      +ivy-buffer-preview t                ; preview buffer on switch
      ;; emojify-emoji-set ""  ; increase resolution from default "emojione-v2.2.6-22"
      emojify-emoji-set "emojione-v2.2.6"  ; increase resolution from default "emojione-v2.2.6-22"
      ;; fringe-mode 'nil  ; should be a number
      emojify-display-style 'unicode
      large-file-warning-threshold nil)
;; Don't highlight the line
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
;; Icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; Disable git gutter by default
(global-git-gutter-mode -1)
(setq git-gutter:disabled-modes
      '(fundamental-mode image-mode pdf-view-mode org-mode prog-mode dired-mode))
;; Highlight-indent-guide (package)
(setq highlight-indent-guides-method 'character
      highlight-indent-guides-responsive 'stack)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'org-mode-hook 'highlight-indent-guides-mode)  ; FIXME background off in code blocks
;; ;; Fringes
;; (add-hook! 'doom-init-ui-hook (fringe-mode '20)) ; FIXME very not loading on startup
;; (setq fringe-mode '('4  . '8)) ; FIXME very not loading on startup
;; (set-fringe-mode nil)

;; ;; Raibow-mode: colorise strings that represent colors. e.g. #fffffff
;; ;; BUG: causing a mess in doom load screen
;; (define-globalized-minor-mode global-rainbow-mode rainbow-mode
;;   (lambda () (rainbow-mode 1)))
;; (global-rainbow-mode 1)

(setq
  doom-font (font-spec :family "DM Mono" :size 22)
  ;; doom-font (font-spec :family "Hasklug Nerd Font Mono" :size 26 :height 1.0)
  ;; doom-font (font-spec :family "Agave Nerd Font Mono")
  ;; doom-font (font-spec :family "Cousine Nerd Font Mono" ) ;; TODO size
  ;; doom-font (font-spec :family "Noto Sans")
  ;; doom-font (font-spec :family "Source Sans Pro")
  ;; doom-variable-pitch-font (font-spec :family "ETBookOT")
  doom-variable-pitch-font (font-spec :family "Source Sans Pro")
  doom-serif-font (font-spec :family "ETBookOT")
  ;; doom-variable-pitch-font (font-spec :family "Iosevka Aile") ; :size 32 :height 1.5)
  ;; doom-variable-pitch-font (font-spec :family "TSCu_Comic")
  doom-unicode-font (font-spec :family "Symbola")          ; good unicode support (prev :size 30)
  ;; doom-big-font (font-spec :family "Fira Mono" :size 19))
)
;; (doom-big-font-mode 1)  ; re add?

;; (use-package! mixed-pitch
;;   :hook (org-mode . mixed-pitch-mode)
;;   :config
;;   (setq mixed-pitch-set-heigth t)
;;   (set-face-attribute 'variable-pitch nil :height 1.0))

(setq doom-modeline-height 40
      ;; doom-modeline-indent-info t
      doom-modeline-vcs-max-length 12
      doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-icon t
      doom-modeline-major-mode-icon t
      doom-modeline-enable-word-count t
      ;; doom-modeline-hud t ;; ?
      doom-modeline-major-mode-color-icon nil)

;; main modline
(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs " "))) ; <-- added padding here

(setq all-the-icons-scale-factor 0.9)  ;; 1.1.

; mini-modeline
(use-package mini-modeline
  :after doom-modeline
  ;; :hook ((after-init . mini-modeline-mode))
        ;; (aorst--theme-change . aorst/mini-modeline-setup-faces)
        ;; (isearch-mode . aorst/mini-modeline-isearch)
        ;;(isearch-mode-end . aorst/mini-modeline-isearch-end)
  :custom
  (mini-modeline-display-gui-line nil)
  ;; (mini-modeline-l-format '(:eval (string-trim-left (eval mode-line-l-format)))) ; FIXME
  ;; (mini-modeline-r-format '(:eval (eval mode-line-r-format)))
  (mini-modeline-r-format '(:eval (doom-modeline-format--minibuffer-line)))
  :config
  (doom-modeline-def-modeline 'minibuffer-line
    '(modals buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs " "))
    ;; NOTE remove `buffer-info` once tabs setup!
  :hook (after-init . mini-modeline-mode))

(global-hide-mode-line-mode 1)

;; FIXME breaking org roam insert (double #+title)
;; (after! doom-modeline
;;   (add-hook 'text-mode-hook #'mini-modeline-mode))

(global-org-modern-mode)
(set-face-attribute 'org-modern-symbol nil :family "DM Mono")

;; Add frame borders and window dividers
;; (modify-all-frames-parameters
;;  '((right-divider-width . 10)
;;    (internal-border-width . 10)))

;; (dolist (face '(window-divider
;;                 window-divider-first-pixel
;;                 window-divider-last-pixel))
;;   (face-spec-reset-face face)
;;   (set-face-foreground face (face-attribute 'default :background)))
;; (set-face-background 'fringe (face-attribute 'default :background))

(setq
;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t)
 ;; ;; Agenda styling
 ;; org-agenda-tags-column 0
 ;; org-agenda-block-separator ?─
 ;; org-agenda-time-grid
 ;; '((daily today require-timed)
 ;;   (800 1000 1200 100 1600 1800 2000)
 ;;   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 ;; org-agenda-current-time-string
 ;; "⭠ now ─────────────────────────────────────────────────")

(after! org
  (setq org-todo-keywords '(
    (sequence "TODO(t)" "DOING(d)" "STRT(s)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "MAYBE(m)" "ERROR(e)" "FIXME(f)" "UPDATE(u)" "MOVE(M)" "REMOVE(r)" "(x)" "|" "DONE(D)" "CANCEL(c)" "DEPRECATED(z)")
    (sequence "[ ](T)" "[-](-)" "[?](?)" "[!](1)" "|" "[X](X)" "[.](.)")
    (sequence "EPIC(E)" "SPRINT(S)" "|")  ;; need trailing bar or last is DONE state
    (sequence "OKAY(o)" "YES(y)" "|" "NO(N)")))

  (setq org-todo-keyword-faces '(
    ("TODO" . (:foreground "DarkSeaGreen3" :weight semi-bold))
    ("DOING" . (:foreground "light goldenrod" :weight semi-bold +org-todo-active))
    ("STRT" . (:foreground "#9083e6" :weight semi-bold +org-todo-active))
    ("NEXT" . (:foreground "light salmon" :weight semi-bold))
    ("PROJ" . (:foreground "PeachPuff3" :weight semi-bold +org-todo-project))
    ("WAIT" . (:foreground "powder blue" :weight semi-bold +org-todo-onhold))
    ("MAYBE" . (:foreground "light pink" :weight semi-bold +org-todo-onhold))
    ("ERROR" . (:foreground "IndianRed" :weight semi-bold))
    ("FIXME" . (:foreground "IndianRed4" :weight semi-bold))
    ("UPDATE" . (:weight semi-bold))
    ("REMOVE" . (:foreground "IndianRed4" :weight semi-bold))
    ("CANCEL" . (:foreground "grey11" :weight semi-bold +org-todo-cancel))
    ;;
    ("SPRINT" . (:foreground "light goldenrod" :weight semi-bold +org-todo-active))
    ("EPIC" . (:foreground "PeachPuff3" :weight semi-bold +org-todo-project))
    ;;
    ("[-]" . (+org-todo-active))
    ("[?]" . (+org-todo-onhold))
    ("[!]" . (:foreground "IndianRed4"))))
    ;; ("[.]" . (:foreground "IndianRed4"))))
    ;; ("YES" . (:foreground "DarkSeaGreen3"))
    ;; ("NO" . (+org-todo-cancel))))

  (setq org-modern-todo-faces '(
    ("TODO" :background "DarkSeaGreen3" :foreground "black")
    ("DOING" :background "light goldenrod" :foreground "black")
    ("STRT" :background "#9083e6" :foreground "black")
    ("NEXT" :background "light salmon" :foreground "black")
    ("PROJ" :background "PeachPuff3" :foreground "black")
    ("WAIT" :background "powder blue" :foreground "black")
    ("MAYBE" :background "light pink" :foreground "black")
    ("ERROR" :background "IndianRed" :foreground "black")
    ("FIXME" :background "IndianRed4" :foreground "black")
    ("UPDATE" :background "sea green" :foreground "black")
    ("REMOVE" :background "IndianRed4" :foreground "black")
    ("CANCEL" :background "grey11" :foreground "black")
    ;;
    ("SPRINT" :background "light goldenrod" :foreground "black")
    ("EPIC" :background "PeachPuff3" :foreground "black")
    ;;
    ;; ("[ ]" :background "green" :foreground "black")
    ;; ("[X]" :foreground "black")
    ;; ("[-]" :foreground "black")
    ;; ("[?]" :foreground "black")
    ;; ("[!]" :foreground "black")))
    ;;
    ;; ("YES" . (:foreground "DarkSeaGreen3"))
    ;; ("NO" . (+org-todo-cancel))))
    ))
)

;; Default header args
(setq org-babel-default-header-args
  '((:session . "none")
    (:results . "replace")
    (:exports . "code")
    (:cache . "no")
    (:noweb . "no")
    (:hlines . "no")
    (:tangle . "no")
    (:comments . "link")))
;; Babel languages
(org-babel-do-load-languages
  'org-babel-load-languages
    '((C. t)
      (dot . t)
      (haskell . t)
      (js . t)
      (json . t)
      (julia . t)
      (nix .t)
      (python . t)
      (rust . t)
      ;; (sh . t)
      (typescript . t)
      (jupyter . t)))  ; NOTE: jupyter must be load last
;; Typescript
(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

;; (defalias 'org-babel-execute:ts 'org-babel-execute:typescript) ; FIXME

(defun display-ansi-colors ()
(ansi-color-apply-on-region (point-min) (point-max)))
(add-hook 'org-babel-after-execute-hook #'display-ansi-colors)

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(after! ox-latex
  (setq org-latex-pdf-process '("latexmk -f -pdf %f -output-directory=%o -shell-escape")))

;; Need from latex minted package
(setq org-latex-listings 'minted
      org-latex-minted-options '(("breaklines" "true")
                                 ;; ("" "")
                                 ("breakanywhere" "true")
                                 ;; ("framesep" "2mm")
                                 ("baselinestretch" "1.1")    ;; line spacing
                                 ;; ("fontsize" "\footnotesize")  ;;
                                 ;; ("fontsize" "16")  ;;
                                 ("linenos" "true")
                                 ("numbersep" "4pt")
                                 ("mathescape" "true")        ;; allows $$ latex in comments
                                 ;; ("bgcolor=grey!10!white")       ;; FIXME broken
                                 ;; ("frame" "single")))         ;; frame line
))

(setq org-latex-packages-alist '(("" "minted")))

(setq org-latex-caption-above nil)

;; svg rendering (to PDF via Inkscape)
;; NOTE must have inkscape installed and svg be in same folder
;; (setq org-latex-pdf-process
;;       (let
;;           ((cmd (concat "pdflatex -shell-escape -interaction nonstopmode"
;;                 " --synctex=1"
;;                 " -output-directory %o %f")))
;;         (list cmd
;;           "cd %o; if test -r %b.idx; then makeindex %b.idx; fi"
;;           "cd %o; bibtex %b"
;;           cmd
;;           cmd)))

(with-eval-after-load 'ox-latex
  (setq org-latex-classes
    '(("infthesis"
      "\\documentclass[logo,bsc,singlespacing,parskip]{infthesis} [NO-PACKAGES]"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

    ("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

    ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

    ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))

;; TypeScript
(setq org-babel-default-header-args:jupyter-typescript '(
  (:session . "ts")
  (:kernel . "tslab")))
;; Python
(setq org-babel-default-header-args:jupyter-python '(
   (:session . "py")
   ;; (:pandoc . "t")
   (:kernel . "python")))
;; Haskell
(setq org-babel-default-header-args:jupyter-haskell '(
   (:session . "hs")
   (:kernel . "haskell")))
;; Julia
(setq org-babel-default-header-args:jupyter-julia '(
  (:session . "jl")
  (:kernel . "julia-1.7")))

; this seems to add syntax-highlighting to jupyter-python and jupyter-typescript blocks
(after! org-src
  (dolist (lang '(python typescript jupyter))
  (cl-pushnew (cons (format "jupyter-%s" lang) lang)
                org-src-lang-modes :key #'car))
  ;;(org-babel-jupyter-override-src-block "python") ;; alias all python to jupyter-python
  ;;(org-babel-jupyter-override-src-block "typescript") ;; alias all python to jupyter-python
)

(setq org-roam-directory "~/org/roam")

      ;; +org-roam-open-buffer-on-find-file nil)

; FIXME: way to exclude nodes in roam-dir from search graph
;; (setq org-roam-db-node-include-function (lambda ()
;;   (not (member "ROAM_EXCLUDE" (org-get-tags)))))

(setq org-roam-capture-templates
;; Default
  `(("d" "default" plain "%?"
    :if-new (file+head "${slug}.org"
"
#+title: ${title}
#+filetags:\n")
    :unnarrowed t)

;; ;; ;; TEST: properties drawer FIXME
;;     ("t" "test" plain "%?"
;;            :if-new (file+head "${slug}.org"
;;                               ":PROPERTIES:
;; :ROAM_ALIASES: %^{aliases}
;; :END:
;; ,#+title: ${title}\n")
;;            :immediate-finish t
;;            :unnarrowed t)))

;; Code Challange
  ("c" "Code Challange" plain "%?"
    :unnarrowed t
    :immediate-finish t
    :if-new (file+head "CodeChallanges/${slug}.org"
":PROPERTIES:
:Source:
:Difficulty:
:Rating:
:END:\n

#+title: ${title}
#+filetags: code-challange rust

\n* Question
\n** Examples
\n*** Example 1
: Input:
: Output:

\n* Solution
\n#+begin_src rustic
\n#+end_src

\n* Testing
\n#+begin_src rustic
\n#+end_src
\n* Runtime Analysis"))


;; Debug/Troubleshooting
  ("D" "Debug/Error/Fix-me" plain "%?"
    :if-new (file+head "${slug}.org"

"#+title: ${title}
#+filetags: :debug:

\n* Problem
\n* TODO Solution")

    :unnarrowed t)

;; Cheatsheet
  ("C" "cheatsheet" plain "%?"
    :if-new (file+head "cheatsheets/${slug}.org"

"#+title: ${title}
#+filetags: :cheatsheat:\n

| Command | Description |
|---------+-------------|
|         |             |")

    :unnarrowed t)

;; Todo (Kanban)
  ("t" "Todo" plain "%?"
    :if-new (file+head "Todo/${slug}.org"


"#+title: ${title}
#+filetags:
#+startup: show2levels
#+CATEGORY:

\n* DOING
\n* NEXT
\n* TODO
\n* DONE")
    :unnarrowed t)))

;; only open one dired buffer at a time

(setf dired-kill-when-opening-new-dired-buffer t)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(add-hook 'writeroom-mode-hook #'(lambda () (text-scale-increase 1)))

(setq lsp-ui-doc-enable t
      lsp-ui-doc-show-with-cursor t
      lsp-lens-enable t
      lsp-headerline-breadcrumb-enable t
      lsp-ui-sideline-enable t
      lsp-ui-sideline-show-code-actions t
      lsp-ui-sideline-enable t
      lsp-ui-sideline-show-hover t
      lsp-modeline-code-actions-enable t
      lsp-signature-render-documentation t
      lsp-completion-show-detail t
      lsp-completion-show-kind t)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
