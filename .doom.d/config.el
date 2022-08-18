;; [[file:config.org::*Better Defaults][Better Defaults:2]]
(setq initial-major-mode 'org-mode
      image-use-external-converter t)
;; Better Defaults:2 ends here

;; [[file:config.org::*User Info][User Info:1]]
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")
;; User Info:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
;; Dark
;; (setq doom-theme 'my-doom-dark+)
(setq doom-theme 'my-doom-one)
;; (setq doom-theme 'my-doom-gruvbox)
;; Light
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'modus-operandi)
;; Theme:1 ends here

;; [[file:config.org::*General][General:1]]
;; (add-hook 'window-setup-hook 'on-after-init)
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)



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
;; General:1 ends here

;; [[file:config.org::*Fonts][Fonts:1]]
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
;; text zoom in/out ammount
(setq text-scale-mode-step 1.05)
;; Fonts:1 ends here

;; [[file:config.org::*Transparency][Transparency:1]]
;; ;; background only transparency (Emacs 29)

 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
 ;;(set-frame-parameter (selected-frame) 'alpha <both>)
 (set-frame-parameter (selected-frame) 'alpha 93)
 (add-to-list 'default-frame-alist '(alpha . 93))

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(93 . 93) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency)

 ;; (global-set-key (kbd "SPC t T") 'toggle-transparency)


;; no background in termincal emacs
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'my-awesome-theme t)
(set-face-background 'default nil)
(set-face-attribute 'default nil :background nil)

(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
    (set-face-background 'default "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)
;; Transparency:1 ends here

;; [[file:config.org::*padding/boarder/margins][padding/boarder/margins:1]]
;; (internal-border-width . 10)
;; (set-window-margins (selected-window) 1 1)
 ;; (setq-default left-margin-width 10 right-margin-width 8) ; Define new widths.
(setq-default left-margin-width 1 right-margin-width 1)
(add-hook! '+popup-buffer-mode-hook
  (set-window-margins (selected-window) 1 1))
;; padding/boarder/margins:1 ends here

;; [[file:config.org::*Window dividers][Window dividers:1]]
;; size
(setq window-divider-default-bottom-width 2 ; in pixels
      window-divider-default-right-width 2)
(window-divider-mode +1)
;; color
; do in theme 'vertical-bar'
;; Window dividers:1 ends here

;; [[file:config.org::*FIXME Scroll bar (yascroll)][FIXME Scroll bar (yascroll):1]]
(add-hook 'prog-mode-hook 'yascroll-bar-mode)
(add-hook 'org-mode-hook 'yascroll-bar-mode)
(setq yascroll:delay-to-hide 'nil)
;; FIXME Scroll bar (yascroll):1 ends here

;; [[file:config.org::*~emacs-terminal-cursor-changer~][~emacs-terminal-cursor-changer~:1]]
(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))
;; ~emacs-terminal-cursor-changer~:1 ends here

;; [[file:config.org::*Modeline][Modeline:1]]
(setq doom-modeline-height 25
      ;; doom-modeline-indent-info t
      doom-modeline-vcs-max-length 12
      doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-icon nil
      doom-modeline-major-mode-icon t
      doom-modeline-enable-word-count t
      ;; doom-modeline-hud t ;; ?
      ;; doom-modeline-major-mode-color-icon nil)
      )

;; main modline
;; (after! doom-modeline
;;   (doom-modeline-def-modeline 'main
;;     '(bar matches buffer-info remote-host buffer-position parrot selection-info)
;;     '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs " "))) ; <-- added padding here

(setq all-the-icons-scale-factor 0.9)  ;; 1.1.

                                        ; mini-modeline
(use-package mini-modeline
  :after doom-modeline
  :hook ((after-init . mini-modeline-mode))
  (aorst--theme-change . aorst/mini-modeline-setup-faces)
  (isearch-mode . aorst/mini-modeline-isearch)
  (isearch-mode-end . aorst/mini-modeline-isearch-end)
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
;; Modeline:1 ends here

;; [[file:config.org::*FIXME General (inc. UI)][FIXME General (inc. UI):1]]
(after! org
  (add-hook! 'org-mode-hook #'+org-pretty-mode   ; hides emphasis markers and toggles "pretty entities"
                            #'org-appear-mode))    ; expand invisible emphasis markers etc.
                            ;; #'mixed-pitch-mode)) ; uses var-pitch font for text; writeroom does this (and doesnt turn it off on exit!)
(after! org
  (setq org-directory "~/org"              ; dir for agenda etc.
        org-startup-folded 't
        org-num-skip-unnumbered 't         ; skip `:UNNUMBERED:` from numbering
        org-ellipsis "  "
        ;; display-line-numbers-type 'nil     ; no line numbers by default in org
        ;; org-image-actual-width 450      ; set default width ; FIXME cannot override
        ;; org-startup-with-latex-preview 't ; TODO test breaking?
        org-startup-shrink-all-tables 't
        org-startup-indented 'nil          ; dont indent in nested headings
        org-id-link-to-org-use-id 't
        ;; org-appear-autolinks 't            ; auto appear links
        ;; org-appear-autosubmarkers 't       ; auto apear subscript/superscript
        ;; org-appear-autoentities 't         ; auto apear \alpha etc.
        ;; org-appear-autokeywords 't         ; auto apear elements in `org-hidden-keywords'
        org-startup-with-inline-images 't
        org-indent-indentation-per-level 0
        org-startup-folded 't))
;; FIXME General (inc. UI):1 ends here

;; [[file:config.org::*Org Modern][Org Modern:1]]
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

(setq org-modern-star nil)  ;; not loading!
(setq org-modern-hide-stars nil)

;; Recommended settings
(setq

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
;; Org Modern:1 ends here

;; [[file:config.org::*Todo's][Todo's:1]]
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
;; Todo's:1 ends here

;; [[file:config.org::*main][main:1]]
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
;; main:1 ends here

;; [[file:config.org::*fix emacs-jupyter output results ansi formatting][fix emacs-jupyter output results ansi formatting:1]]
(defun display-ansi-colors ()
(ansi-color-apply-on-region (point-min) (point-max)))
(add-hook 'org-babel-after-execute-hook #'display-ansi-colors)
;; fix emacs-jupyter output results ansi formatting:1 ends here

;; [[file:config.org::*Latex Export][Latex Export:1]]
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(after! ox-latex
  (setq org-latex-prefer-user-labels t)
  (setq org-latex-compiler "xelatex")
  (setq org-latex-pdf-process '("latexmk -xelatex -f -pdf %f -output-directory=%o -shell-escape")))
  ;; (setq org-latex-pdf-process
  ;;   '("xelatex -interaction nonstopmode -output-directory %o %f -shell-escape"
  ;;     "xelatex -interaction nonstopmode -output-directory %o %f -shell-escape"
  ;;     "xelatex -interaction nonstopmode -output-directory %o %f -shell-escape")))
  ;; ;; ^ for multiple passes

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

(setq org-latex-packages-alist '(("" "minted")("" "fontspec")))

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
;; Latex Export:1 ends here

;; [[file:config.org::*emacs-jupyter][emacs-jupyter:1]]
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
;; emacs-jupyter:1 ends here

;; [[file:config.org::*General][General:1]]
(setq org-roam-directory "~/org/roam")

      ;; +org-roam-open-buffer-on-find-file nil)

; FIXME: way to exclude nodes in roam-dir from search graph
;; (setq org-roam-db-node-include-function (lambda ()
;;   (not (member "ROAM_EXCLUDE" (org-get-tags)))))
;; General:1 ends here

;; [[file:config.org::*Org Roam Capture Templates][Org Roam Capture Templates:1]]
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
:Source: %^{source}
:Difficulty:
:Rating:
:END:\n

#+title: ${title}
#+filetags: code-challange rust
#+property: header-args :tangle src/${slug}.rs :comments link

\n* Question
\n** Examples
\n*** Example 1
: Input:
: Output:

\n* Solution
\n#+name: solution
\n#+begin_src rustic
\n#+end_src

\n#+name: testing
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
;; Org Roam Capture Templates:1 ends here

;; [[file:config.org::*Hide radio-target syntax in node name][Hide radio-target syntax in node name:1]]
(defun org-link-display-format-h (s)
  "Replace radio links in string S with their description.
If there is no description, use the link target."
  (save-match-data
    (replace-regexp-in-string
     org-radio-target-regexp
     (lambda (m) (or (match-string 2 m) (match-string 1 m)))
     s nil t)))

(advice-add  'org-link-display-format :filter-return 'org-link-display-format-h)
;; Hide radio-target syntax in node name:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
;; only open one dired buffer at a time

(setf dired-kill-when-opening-new-dired-buffer t)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; Dired:1 ends here

;; [[file:config.org::*Writeroom mode][Writeroom mode:1]]
(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(add-hook 'writeroom-mode-hook #'(lambda () (text-scale-increase 1)))
;; Writeroom mode:1 ends here

;; [[file:config.org::*LSP][LSP:1]]
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
;; LSP:1 ends here

;; [[file:config.org::*Tree sittier][Tree sittier:1]]
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
;; Tree sittier:1 ends here
