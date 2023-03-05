;; [[file:config.org::*Better defaults][Better defaults:1]]
(setq initial-major-mode 'org-mode
      image-use-external-converter t
      lisp-indent-offset 2)
;; Better defaults:1 ends here

;; [[file:config.org::*User info][User info:1]]
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")
;; User info:1 ends here

;; [[file:config.org::*General][General:1]]
(setq-default word-wrap t)
              ;; line-spacing 0.15)
(setq display-line-numbers-type t         ; 'relative  ; or `nil'
      +ivy-buffer-preview t               ; preview buffer on switch
      emojify-emoji-set "emojione-v2.2.6" ; increase resolution from default "emojione-v2.2.6-22"
      emojify-display-style 'unicode
      large-file-warning-threshold nil)
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode) ; don't highlight the line
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode) ; icons in dired
;; General:1 ends here

;; [[file:config.org::*Fringes][Fringes:1]]
;; ;;; Fringes
;; (add-hook! 'doom-init-ui-hook (fringe-mode '20)) ; FIXME very not loading on startup
;; (setq fringe-mode '('4  . '8)) ; FIXME very not loading on startup
;; (set-fringe-mode nil)
;; Fringes:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
;; Dark
;; (setq doom-theme 'my-doom-dark+)
;; (setq doom-theme 'my-doom-one)
;; (setq doom-theme 'my-doom-gruvbox)
;; Light
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'modus-operandi)
(setq doom-theme 'modus-vivendi)
;; Theme:1 ends here

;; [[file:config.org::*Modus themes][Modus themes:1]]
(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "modus theme" "t" #'modus-themes-toggle))
;; Modus themes:1 ends here

;; [[file:config.org::*Fonts][Fonts:1]]
;; FIXME breaks scaling
(setq
  doom-font (font-spec :family "DM Mono" :size 28) ;; ! `doom-big-mode' breaks when `:size'`
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

;; (set-face-attribute 'fixed-pitch nil :family "DM Mono" :inherit 'default)
;; Fonts:1 ends here

;; [[file:config.org::*Transparency][Transparency:1]]
;; ;; background only transparency (Emacs 29)
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
;;; Emacs 28
(set-frame-parameter (selected-frame) 'alpha 85) ; 93
(add-to-list 'default-frame-alist '(alpha . 85)) ; 93

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
         '(85 . 85) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)
;; (map! :leader
;;       (:prefix-map ("t" . "toggle")
;;        :desc "transparency" "x" 'toggle-transparency))

;;; no background in termincal emacs
(set-face-background 'default nil)
(set-face-attribute 'default nil :background nil)
;; Transparency:1 ends here

;; [[file:config.org::*padding/boarder/margins][padding/boarder/margins:1]]
(setq-default left-margin-width 1 right-margin-width 1)
(add-hook! '+popup-buffer-mode-hook
  (set-window-margins (selected-window) 1 1))
;; padding/boarder/margins:1 ends here

;; [[file:config.org::*Window dividers][Window dividers:1]]
(window-divider-mode +1) ;; visible window divider
(setq window-divider-default-bottom-width 3 ; size in pixels
      window-divider-default-right-width 3)
;; NOTE: name in theme: 'vertical-bar'
;; Window dividers:1 ends here

;; [[file:config.org::*~highligh-indent-guide~ (code fences)][~highligh-indent-guide~ (code fences):1]]
;; Highlight-indent-guide (package)
(setq highlight-indent-guides-method 'character
      highlight-indent-guides-responsive 'stack)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'org-mode-hook 'highlight-indent-guides-mode)  ; FIXME background off in code blocks
;; ~highligh-indent-guide~ (code fences):1 ends here

;; [[file:config.org::*diff-hl (git diff fringe)][diff-hl (git diff fringe):1]]
;;   (global-diff-hl-mode -1) ;; FIXME
(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "git diff-hl fringe" "d" #'diff-hl-mode))
;; diff-hl (git diff fringe):1 ends here

;; [[file:config.org::*~emacs-terminal-cursor-changer~ (vim state in term)][~emacs-terminal-cursor-changer~ (vim state in term):1]]
(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))
;; ~emacs-terminal-cursor-changer~ (vim state in term):1 ends here

;; [[file:config.org::*Don't load background in terminal][Don't load background in terminal:1]]
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'on-frame-open)
;; (defun on-frame-open (frame)
;;   (if (not (display-graphic-p frame))
;;     (set-face-background 'default "unspecified-bg" frame)))
;; (on-frame-open (selected-frame))
;; (add-hook 'after-make-frame-functions 'on-frame-open)
;; (defun on-after-init ()
;;   (unless (display-graphic-p (selected-frame))
;;     (set-face-background 'default "unspecified-bg" (selected-frame))))
;; (add-hook 'window-setup-hook 'on-after-init)
;; Don't load background in terminal:1 ends here

;; [[file:config.org::*no 'relative' line numbers][no 'relative' line numbers:1]]
;; lib: lisp/lib/ui.el
(eval-after-load "ui" ;; <- TODO package name?
'(defun doom/toggle-line-numbers ()
  "Toggle line numbers.
Cycles through regular, relative and no line numbers. The order depends on what
`display-line-numbers-type' is set to. If you're using Emacs 26+, and
visual-line-mode is on, this skips relative and uses visual instead.
See `display-line-numbers' for what these values mean."
  (interactive)
  (defvar doom--line-number-style display-line-numbers-type)
  (let* ((styles `(t nil))
         (order (cons display-line-numbers-type (remq display-line-numbers-type styles)))
         (queue (memq doom--line-number-style order))
         (next (if (= (length queue) 1)
                   (car order)
                 (car (cdr queue)))))
    (setq doom--line-number-style next)
    (setq display-line-numbers next)
    (message "Switched to %s line numbers"

             (pcase next
               (`t "normal")
               (`nil "disabled")
               (_ (symbol-name next))))))
)
;; no 'relative' line numbers:1 ends here

;; [[file:config.org::*~my/company-show-doc-buffer~][~my/company-show-doc-buffer~:1]]
(defun my/company-show-doc-buffer ()
  "Temporarily show the documentation buffer for the selection."
  (interactive)
  (let* ((selected (nth company-selection company-candidates))
         (doc-buffer (or (company-call-backend 'doc-buffer selected)
                         (error "No documentation available"))))
    (with-current-buffer doc-buffer
      (goto-char (point-min)))
    (display-buffer doc-buffer t)))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-<f1>") #'my/company-show-doc-buffer))
;; ~my/company-show-doc-buffer~:1 ends here

;; [[file:config.org::*General (inc. UI)][General (inc. UI):1]]
(after! org
  (add-hook! 'org-mode-hook #'+org-pretty-mode    ; hides emphasis markers and toggles "pretty entities"
                            #'org-appear-mode))     ; expand invisible emphasis markers when insdie them etc.
                            ;; #'org-bars-mode))     ; indentation guides for org mode headings
(after! org
  (setq org-directory "~/org"               ; dir for agenda etc.
        org-startup-folded 't
        org-num-skip-unnumbered 't          ; skip `:unnumbered:` from numbering
        org-ellipsis "  "
        ;; org-ellipsis "  "
        ;; display-line-numbers-type 'nil      ; no line numbers by default in org
        ;; org-image-actual-width 450          ; set default width ; FIXME cannot override
        ;; org-startup-with-latex-preview 't   ; TODO test breaking?
        org-startup-shrink-all-tables 't
        org-startup-indented 't             ; dont indent in nested headings
        org-id-link-to-org-use-id 't
        org-appear-autolinks 't            ; auto appear links
        org-appear-autosubmarkers 't       ; auto apear subscript/superscript             ; FIXME very slow? {
        org-appear-autoentities 't         ; auto apear \alpha etc.
        org-appear-autokeywords 't         ; auto apear elements in `org-hidden-keywords' ; } END FIXME
        org-startup-with-inline-images 't
        ;; org-indent-indentation-per-level 0   ; indentation of body per heading
        ;; org-hide-leading-stars 'nil
        org-startup-folded 't))

;; FIXME Remove org-ellipsis
(defun org-no-ellipsis-in-headlines ()
  "Remove use of ellipsis in headlines. See `buffer-invisibility-spec'."
  (remove-from-invisibility-spec '(outline . t))
  (add-to-invisibility-spec 'outline))
(add-hook! 'org-mode-hook 'org-no-ellipsis-in-headlines)
;; General (inc. UI):1 ends here

;; [[file:config.org::*Todo's][Todo's:1]]
(after! org
  (setq org-todo-keywords '(
    (sequence "TODO(t)" "DOING(d)" "STRT(s)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "MAYBE(m)" "ERROR(e)" "FIXME(f)" "UPDATE(u)" "REVIEW(r)" "MOVE(M)" "REMOVE(R)" "(x)" "|" "DONE(D)" "CANCEL(c)" "DEPRECATED(z)")
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
    ("REVIEW" . (:foreground "DarkSeaGreen3" :weight semi-bold))
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
    ("REVIEW" :background "DarkSeaGreen3" :foreground "black")
    ("REMOVE" :background "IndianRed4" :foreground "black")
    ("CANCEL" :background "grey11" :foreground "black")
    ;;
    ("SPRINT" :background "light goldenrod" :foreground "black")
    ("EPIC" :background "PeachPuff3" :foreground "black")
    ;; FIXME casuing message errors
    ("[ ]" :background nil :foreground "DarkSeaGreen")
    ("[X]" :background nil :foreground "grey11")
    ("[-]" :background nil :foreground "RoyalBlue") ; update (RoyalBlue broken)
    ("[?]" :background nil :foreground "light goldenrod")
    ("[!]" :background nil :foreground "IndianRed"))))
    ;; ("YES" :foreground "DarkSeaGreen3"))
    ;; ("NO" (+org-todo-cancel))
;; Todo's:1 ends here

;; [[file:config.org::*Tags][Tags:1]]
(setq org-tag-persistent-alist
      '((:startgroup . nil)
        ("uni" . ?u)
        ("computing" . ?c)
        ("math" . ?*)
        ("philosophy" . ?p)
        ("psychology" . ?q)
        ("research" . ?r)
        ("my" . ?m)
        ("private" . ?M)
        ("xini" . ?X)
        ("money" . ?£)
        (:endgroup . nil)
        ("noexport" . ?x)))
;; Tags:1 ends here

;; [[file:config.org::*Default header args][Default header args:1]]
(setq org-babel-default-header-args
  '((:session  . "none")
    (:results  . "replace")
    (:exports  . "both")
    (:cache    . "no")
    (:noweb    . "no")
    (:hlines   . "no")
    (:tangle   . "no")
    (:eval     . "never-export")
    (:comments . "link")))
;; Default header args:1 ends here

;; [[file:config.org::*Languages][Languages:1]]
;;; Setup
(setq ob-mermaid-cli-path "~/node_modules/.bin/mmdc") ; set up mermaid

;;; Main
(org-babel-do-load-languages
  'org-babel-load-languages
    '((C. t)
      (dot . t)
      (haskell . t)
      (js . t)
      (json . t)
      (julia . t)
      (mermaid . t)
      (nix .t)
      (python . t)
      (rust . t)
      ;; (sh . t)
      (typescript . t)
      (jupyter . t)))  ; NOTE: jupyter must be last

;;; Typescript
(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

;; (defalias 'org-babel-execute:ts 'org-babel-execute:typescript) ; FIXME
;; Languages:1 ends here

;; [[file:config.org::*fix Emacs-jupyter output results ansi formatting][fix Emacs-jupyter output results ansi formatting:1]]
(defun display-ansi-colors ()
(ansi-color-apply-on-region (point-min) (point-max)))
(add-hook 'org-babel-after-execute-hook #'display-ansi-colors)
;; fix Emacs-jupyter output results ansi formatting:1 ends here

;; [[file:config.org::*Make org-edit-special (src block) popup in current buffer][Make org-edit-special (src block) popup in current buffer:1]]
(after! org
  (setq org-src-window-setup 'current-window)
  (set-popup-rule! "^\\*Org Src" :ignore t))
;; Make org-edit-special (src block) popup in current buffer:1 ends here

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

;; (setq org-latex-packages-alist '(("" "minted")("" "fontspec")))

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

;; [[file:config.org::*Latex fragments][Latex fragments:1]]
(setq org-format-latex-options
  (list
        :foreground 'default  ;; or `auto'
        ;; :background 'auto
        :scale 1.1  ;; bigger latex fragment
        ;; :html-foreground "Black"
        ;; :html-background "Transparent"
        ;; :html-scale 1.0
        :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))

;; syntax hilighting for latex fragments
(setq org-highlight-latex-and-related '(native script entities))

;; (setq org-latex-create-formula-image-program 'imagemagick) ; Recommended

;; prevent background redering uglyness
;; OLD: https://stackoverflow.com/questions/69474043/emacs-org-mode-background-color-of-latex-fragments-with-org-highlight-latex-a
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

;; Automatically load inline previews with org-fragtog
;; (add-hook 'org-mode-hook 'org-fragtog-mode) ; TODO see if breaking

;; Color transparent rather than match default face
(setq org-format-latex-options
  (plist-put org-format-latex-options :background "Transparent"))

;; specify the justification you want
(plist-put org-format-latex-options :justify 'center)
;; Latex fragments:1 ends here

;; [[file:config.org::*Org Bars (outline vertical guides)][Org Bars (outline vertical guides):1]]
(require 'org-bars)
(after! org (add-hook 'org-mode-hook #'org-bars-mode))
(setq org-bars-stars '(:empty "*" :invisible "*" :visible "*"))
;; (setq org-bars-extra-pixels-height 6) ;; fix gaps in org-bars
;; Org Bars (outline vertical guides):1 ends here

;; [[file:config.org::*Org Modern][Org Modern:1]]
(global-org-modern-mode)
(set-face-attribute 'org-modern-symbol nil :family "DM Mono")
(setq org-modern-star nil)
(setq org-modern-hide-stars nil)
;; Org Modern:1 ends here

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

;; [[file:config.org::*Org-noter][Org-noter:1]]
(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-always-create-frame nil))  ; stop opening frames
;; Org-noter:1 ends here

;; [[file:config.org::*Hypothesis][Hypothesis:1]]
(setq hypothesis-username "nazzacode"
      hypothesis-token "6879-DJYjeV3gat2emzWKlSGkQu20tQTvQK3s7xVSepSdjfA")
;; Hypothesis:1 ends here

;; [[file:config.org::*Hide radio links][Hide radio links:1]]
(defcustom org-hidden-links-additional-re "\\(<<<\\)[[:print:]]+?\\(>>>\\)"
  "Regular expression that matches strings where the invisible-property of the sub-matches 1 and 2 is set to org-link."
  :type '(choice (const :tag "Off" nil) regexp)
  :group 'org-link)
(make-variable-buffer-local 'org-hidden-links-additional-re)

(defun org-activate-hidden-links-additional (limit)
  "Put invisible-property org-link on strings matching `org-hide-links-additional-re'."
  (if org-hidden-links-additional-re
      (re-search-forward org-hidden-links-additional-re limit t)
    (goto-char limit)
    nil))

(defun org-hidden-links-hook-function ()
  "Add rule for `org-activate-hidden-links-additional' to `org-font-lock-extra-keywords'.
You can include this function in `org-font-lock-set-keywords-hook'."
  (add-to-list 'org-font-lock-extra-keywords
                              '(org-activate-hidden-links-additional
                                (1 '(face org-target invisible org-link))
                (2 '(face org-target invisible org-link)))))

(add-hook 'org-font-lock-set-keywords-hook #'org-hidden-links-hook-function)
;; Hide radio links:1 ends here

;; [[file:config.org::*Hide/show properties drawer][Hide/show properties drawer:1]]
;; Funtion to hide/unhide the properties drawer
(defun my/org-toggle-properties ()
  "Hide all org-mode headline property drawers in buffer. Could be slow if it has a lot of overlays."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            "^ *:properties:\n\\( *:.+?:.*\n\\)+ *:end:\n" nil t)
      (let ((ov_this (make-overlay (match-beginning 0) (match-end 0))))
        (overlay-put ov_this 'display "")
        (overlay-put ov_this 'hidden-prop-drawer t))))
  (put 'org-toggle-properties-hide-state 'state 'hidden))

(defun org-show-properties ()
  "Show all org-mode property drawers hidden by org-hide-properties."
  (interactive)
  (remove-overlays (point-min) (point-max) 'hidden-prop-drawer t)
  (put 'org-toggle-properties-hide-state 'state 'shown))

(defun org-toggle-properties ()
  "Toggle visibility of property drawers."
  (interactive)
  (if (eq (get 'org-toggle-properties-hide-state 'state) 'hidden)
      (org-show-properties)
    (org-hide-properties)))
;; Hide/show properties drawer:1 ends here

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
  ("c" "Code Challenge" plain "%?"
    :unnarrowed t
    :immediate-finish t
    :if-new (file+head "CodeChallenges/${slug}.org"
":PROPERTIES:
:Source: %^{source}
:Difficulty:
:Rating:
:END:
#+title: ${title}
#+filetags: code-challange rust
#+property: header-args :tangle src/bin/${slug}.rs :comments link

\n* Question

*Example 1*
: Input:
: Output:

* Solution
#+begin_src rustic
struct Solution {}
impl Solution {
    pub fn foo() {
    }
}
#+end_src

\n* Testing
#+begin_src rustic
#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn test1() { assert_eq!(Solution::foo(), 1) }
}
#+end_src

* Runtime Analysis"))

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

;; [[file:config.org::*org-roam-ui][org-roam-ui:1]]
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
    ;; :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
;; org-roam-ui:1 ends here

;; [[file:config.org::*main][main:1]]
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
;; main:1 ends here

;; [[file:config.org::*mini-modeline][mini-modeline:1]]
;;; mini-modeline
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
;; mini-modeline:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
;; only open one dired buffer at a time

(setf dired-kill-when-opening-new-dired-buffer t)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq dired-listing-switches "-lAX --group-directories-first")
;; Dired:1 ends here

;; [[file:config.org::*Treemacs (file/project explorer)][Treemacs (file/project explorer):1]]
(setq doom-themes-treemacs-enable-variable-pitch nil
     treemacs-width-is-initially-locked 'nil)
;; Treemacs (file/project explorer):1 ends here

;; [[file:config.org::*Pdf (tools)][Pdf (tools):1]]
;; more fine-grained zooming
(setq pdf-view-resize-factor 1.05)

;; pdf-annot-list-format
(setq pdf-annot-list-format '((page . 3) (type . 6) (contents . 24) (date . 20))
      pdf-annot-list-highlight-type 't)

;; restore pdf to previous reading position
(add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode)
;; Pdf (tools):1 ends here

;; [[file:config.org::*Writeroom mode][Writeroom mode:1]]
(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(add-hook 'writeroom-mode-hook #'(lambda () (text-scale-increase 1)))
(add-hook 'writeroom-mode-hook #'(lambda () (mixed-pitch-mode -1)))
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

(setq lsp-headerline-breadcrumb-enable-diagnostics nil)
;; LSP:1 ends here

;; [[file:config.org::*Tree sittier][Tree sittier:1]]
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
;; Tree sittier:1 ends here

;; [[file:config.org::*main][main:1]]
(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "mixed pitch mode" "p" #'mixed-pitch-mode))
;; main:1 ends here

;; [[file:config.org::*VS code emulation][VS code emulation:1]]
;; comment lines
;; ! not working
;; (map! :map global-map "<C-/>" #'evilnc-comment-or-uncomment-lines)
;; :) working
(define-key global-map (kbd "C-/") #'evilnc-comment-or-uncomment-lines)

;; TODO: move lines up/down
;; VS code emulation:1 ends here
