;; [[file:config.org::*Better Defaults][Better Defaults:1]]
;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Better Defaults:1 ends here

;; [[file:config.org::*Better Defaults][Better Defaults:2]]
(setq initial-major-mode 'org-mode
      image-use-external-converter t)
;; Better Defaults:2 ends here

;; [[file:config.org::*Better Defaults][Better Defaults:3]]
(setq auto-save-default t
      initial-major-mode 'org-mode
      make-backup-files t
      lisp-indent-offset 2)

(setq backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq-default tab-width 2)
(setq straight-allow-recipe-inheritance nil)
;; Better Defaults:3 ends here

;; [[file:config.org::*User Info][User Info:1]]
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")
;; User Info:1 ends here

;; [[file:config.org::*General][General:1]]
(setq-default word-wrap t
              line-spacing 0.0)
(setq display-line-numbers-type t         ; 'relative  ; or `nil'
      +ivy-buffer-preview t               ; preview buffer on switch
      emojify-emoji-set "emojione-v2.2.6" ; increase resolution from default "emojione-v2.2.6-22"
      emojify-display-style 'unicode
      large-file-warning-threshold nil)
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode) ; don't highlight the line
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)       ; icons in dired
;; General:1 ends here

;; [[file:config.org::*Fringes][Fringes:1]]
;; ;;; Fringes
;; (add-hook! 'doom-init-ui-hook (fringe-mode '20)) ; FIXME very not loading on startup
;; (setq fringe-mode '('4  . '8)) ; FIXME very not loading on startup
;; (set-fringe-mode nil)

;;; Prevent word wrap changing fringe indicator
;; This should cover most modes: https://www.gnu.org/software/emacs/manual/html_node/elisp/Basic-Major-Modes.html
;; (add-hook! '(prog-mode-hook special-mode-hook text-mode-hook)
;;   (setf fringe-indicator-alist (remove '(continuation nil nil) fringe-indicator-alist))
;;   (toggle-word-wrap -1))

;;; Remove overflow character
(setq-default fringe-indicator-alist
              (delq (assq 'truncation fringe-indicator-alist) fringe-indicator-alist))
;; Fringes:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
;; Dark
(setq doom-theme 'my-doom-dark+)
;; (setq doom-theme 'my-doom-one)
;; (setq doom-theme 'my-doom-gruvbox)
;; Light
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'modus-operandi)
;; Theme:1 ends here

;; [[file:config.org::*Fonts][Fonts:1]]
;; - must set ~doom-font~ size for (disable)-~doom-big-mode~ to return font to orginal size.
(setq
  ;;; TODO Doom Font: EXPLAIN
  ;; doom-font (font-spec :size 28)
  ;; doom-font (font-spec :family "Cousine Nerd Font Mono" :size 28)

  ;; doom-font (font-spec :family "DM Mono" :size 22)
  ;; doom-font (font-spec :family "Hack" :size 22)
  ;; doom-font (font-spec :family "Aldrich" :size 22)
  ;; doom-font (font-spec :family "Hasklug Nerd Font Mono" :size 26 :height 1.0)
  ;; doom-font (font-spec :family "Agave Nerd Font Mono")
  ;; doom-font (font-spec :family "Noto Sans")
 doom-font (font-spec :family "Source Code Pro" :size 28 :height 1.0)
  ;;; Variable Pitch:
  ;; doom-variable-pitch-font (font-spec :height 1.0)
  ;; doom-variable-pitch-font (font-spec :family "Cousine Nerd Font Mono" :height 1.0)
 ;; doom-variable-pitch-font (font-spec :family "ETBookOT" :height 1.5)
  ;; doom-variable-pitch-font (font-spec :family "Source Sans Pro")
  ;; doom-variable-pitch-font (font-spec :family "Iosevka Aile") ; :size 32 :height 1.5)
  ;; doom-variable-pitch-font (font-spec :family "TSCu_Comic")
  ;; doom-serif-font (font-spec :family "ETBookOT")
  ;;; Unicode:
 doom-unicode-font (font-spec :family "Symbola")          ; good unicode support (prev :size 30)
  ;;; Big:
  ;; doom-big-font (font-spec :size 32) ;; NOTE: setting fucks shit up!
)
;; text zoom in/out ammount
(setq text-scale-mode-step 1.05)


(use-package! mixed-pitch
  ;; :hook (org-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-heigth t)
  (set-face-attribute 'variable-pitch nil :height 2))
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

;; [[file:config.org::*Padding/boarder/margins][Padding/boarder/margins:1]]
;; (internal-border-width . 10)
;; (set-window-margins (selected-window) 1 1)
 ;; (setq-default left-margin-width 10 right-margin-width 8) ; Define new widths
(setq-default left-margin-width 1 right-margin-width 1)
(add-hook! '+popup-buffer-mode-hook
  (set-window-margins (selected-window) 1 1))
;; Padding/boarder/margins:1 ends here

;; [[file:config.org::*Window dividers][Window dividers:1]]
;; size
(setq window-divider-default-bottom-width 2 ; in pixels
      window-divider-default-right-width 2)
(window-divider-mode +1)
;; color: do in theme 'vertical-bar'
;; Window dividers:1 ends here

;; [[file:config.org::*Column cutoff ~visual-fill-mode~)][Column cutoff ~visual-fill-mode~):1]]
(setq-default visual-fill-column-width 90)
(defvar my-visual-fill-column-width 85)
;; (setq visual-fill-column-width 'my-visual-fill-column-width)
(setq visual-fill-column-width 90)
;; Column cutoff ~visual-fill-mode~):1 ends here

;; [[file:config.org::*Column indicator][Column indicator:1]]
(setq-default display-fill-column-indicator-column 79)
(setq display-fill-column-indicator-column 79)
(setq-default display-fill-column-indicator-character ?\u00A6) ; 2502)
;; Column indicator:1 ends here

;; [[file:config.org::*~highligh-indent-guide~ (code fences)][~highligh-indent-guide~ (code fences):1]]
;; Highlight-indent-guide (package)
(setq highlight-indent-guides-method 'character
      highlight-indent-guides-responsive 'stack)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'org-mode-hook 'highlight-indent-guides-mode)  ; FIXME background off in code blocks
;; ~highligh-indent-guide~ (code fences):1 ends here

;; [[file:config.org::*~emacs-terminal-cursor-changer~ (vim state in term)][~emacs-terminal-cursor-changer~ (vim state in term):1]]
(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))
;; ~emacs-terminal-cursor-changer~ (vim state in term):1 ends here

;; [[file:config.org::*Disable spellcheck (~spell-fu~ (not ~flyspell~))][Disable spellcheck (~spell-fu~ (not ~flyspell~)):1]]
(remove-hook 'text-mode-hook #'spell-fu-mode)
;; Disable spellcheck (~spell-fu~ (not ~flyspell~)):1 ends here

;; [[file:config.org::*No background color in terminal][No background color in terminal:1]]
;; NO background color in terminal
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'on-frame-open)
;; No background color in terminal:1 ends here

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

;; [[file:config.org::*FIXME main][FIXME main:1]]
;; FIXME causing crashing!
;; TODO  full completion backend in org mode src blocks?

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(setq company-show-numbers 't           ; M-N to use
      company-minimum-prefix-length 2
      company-selection-wrap-around 't
      company-idle-delay 0.3)

;; ;; NOT WORKING
;; (add-hook 'company-mode-hook
;;   (lambda ()
;;     (add-to-list company-backends '(company-math-symbols-unicode))))

(setq company-math-allow-latex-symbols-in-faces t) ;; allow completion in org-mode text

;; FIXME only enable in certain modes...
;; ;; TabNine (AI autocomplete)
;; (require 'company-tabnine)
;; (add-to-list 'company-backends 'company-tabnine)

;; company-math (latex unicode completions)
(add-to-list 'company-backends 'company-math-symbols-unicode) ; FIXME requires hot reload! (try a hook?)
;; (add-hook 'after-init-hook 'global-company-mode)
;; FIXME main:1 ends here

;; [[file:config.org::*General (including UI)][General (including UI):1]]
(after! org
  (add-hook! 'org-mode-hook #'+org-pretty-mode   ; hides emphasis markers and toggles "pretty entities"
                            #'visual-fill-column-mode
                            #'org-appear-mode))    ; expand invisible emphasis markers etc.
                            ;; #'mixed-pitch-mode)) ; uses var-pitch font for text; writeroom does this (and doesnt turn it off on exit!)
(after! org
  (setq org-directory "~/org"              ; dir for agenda etc.
        org-startup-folded 't
        org-num-skip-unnumbered 't         ; skip `:UNNUMBERED:` from numbering
        org-ellipsis " "                   ; "  "
        ;; display-line-numbers-type 'nil     ; no line numbers by default in org
        ;; org-image-actual-width 450      ; set default width ; FIXME cannot override
        ;; org-startup-with-latex-preview 't ; TODO test breaking?
        org-startup-shrink-all-tables 't
        ;; org-startup-indented 'nil          ; dont indent in nested headings
        org-id-link-to-org-use-id 't
        ;; org-appear-autolinks 't            ; auto appear links
        ;; org-appear-autosubmarkers 't       ; auto apear subscript/superscript
        ;; org-appear-autoentities 't         ; auto apear \alpha etc.
        ;; org-appear-autokeywords 't         ; auto apear elements in `org-hidden-keywords'
        org-startup-with-inline-images 't
        org-indent-indentation-per-level 2
        org-startup-folded 't))

(setq org-adapt-indentation t)
;; General (including UI):1 ends here

;; [[file:config.org::*Headings][Headings:1]]
;; `weights:' can be [normal, semi-bold, bold]
(custom-set-faces!
  '(outline-1 :weight normal :height 1.0 :underline "orange") ;1.26) ;1.12)
  '(outline-2 :weight normal :height 1.0) ;1.16) ;1.08)
  '(outline-3 :weight normal :height 1.0) ;1.10) ;1.05)
  '(outline-4 :weight normal :height 1.0) ;1.06) ;1.03)
  '(outline-5 :weight normal :height 1.0) ;1.04) ;1.02)
  '(outline-6 :weight normal :height 1.0) ;1.02) ;1.01)
  '(outline-7 :weight normal)
  '(outline-8 :weight normal)
  '(org-document-title :weight normal :height 1.0)); 1.8)) ; 1.2

;; Previous symbols: '( "◉" "○" "⎊" "⎉" "⊛" "⊚" "◦" "◘")
;; Headings:1 ends here

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
        ("noexport" . ?x)
))
;; Tags:1 ends here

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

;; [[file:config.org::*Hide/Show Properties Drawer][Hide/Show Properties Drawer:1]]
;; Funtion to hide/unhide the properties drawer
(defun org-hide-properties ()
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
;; Hide/Show Properties Drawer:1 ends here

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

;; [[file:config.org::*Latex fragments][Latex fragments:1]]
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

;; [[file:config.org::*REMOVE helm-bibtex][REMOVE helm-bibtex:1]]
(after! org
  (setq bibtex-completion-bibliography "~/org/roam/Zotero/bibliography.bib"
        bibtex-completion-library-path "~/org/roam/Zotero/storage/."
        bibtex-completion-notes-path "~/org/roam/Zotero/storage"))
;; REMOVE helm-bibtex:1 ends here

;; [[file:config.org::*UPDATE hypothesis][UPDATE hypothesis:1]]
(setq hypothesis-username "nazzacode"
      hypothesis-token "6879-DJYjeV3gat2emzWKlSGkQu20tQTvQK3s7xVSepSdjfA")
;; UPDATE hypothesis:1 ends here

;; [[file:config.org::*org-bars (heading indentation guides)][org-bars (heading indentation guides):1]]
(require 'org-bars)
(after! org (add-hook 'org-mode-hook #'org-bars-mode))
;; (setq org-bars-stars '(:empty "*" :invisible "*" :visible "*"))
;; (setq org-bars-stars '(:empty "◦" :invisible "•" :visible "⦿"))
(setq org-bars-stars '(:empty "*" :invisible "+" :visible "-"))
(setq org-bars-extra-pixels-height 0) ;; fix gaps in org-bars
(setq org-bars-with-dynamic-stars-p 't)
;; org-bars (heading indentation guides):1 ends here

;; [[file:config.org::*org-noter][org-noter:1]]
(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-always-create-frame nil))  ; stop opening frames
;; org-noter:1 ends here

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

;; [[file:config.org::*Dired][Dired:1]]
;; only open one dired buffer at a time

(setf dired-kill-when-opening-new-dired-buffer t)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; Dired:1 ends here

;; [[file:config.org::*Latex][Latex:1]]
(setq org-format-latex-options
  (list
        :foreground 'default  ;; or `auto'
        ;; :background 'auto
        :scale 1.1  ;; bigger latex fragment
        ;; :html-foreground "Black"
        ;; :html-background "Transparent"
        ;; :html-scale 1.0
        :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))
;; Latex:1 ends here

;; [[file:config.org::*~good-scroll~][~good-scroll~:1]]
(good-scroll-mode 1)
;; ~good-scroll~:1 ends here

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

;; [[file:config.org::*Pdf (tools)][Pdf (tools):1]]
;; more fine-grained zooming
(setq pdf-view-resize-factor 1.05)

;; pdf-annot-list-format
(setq pdf-annot-list-format '((page . 3) (type . 6) (contents . 24) (date . 20))
      pdf-annot-list-highlight-type 't)

;; restore pdf to previous reading position
(add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode)

;; ;; Double page spread
;; (defun my-pdf-view-double-scroll-up-or-next-page (&optional arg)
;;   "Scroll page up ARG lines if possible, else go to the next page.

;; When `pdf-view-continuous' is non-nil, scrolling upward at the
;; bottom edge of the page moves to the next page. Otherwise, go to
;; next page only on typing SPC (ARG is nil)."
;;   (interactive "P")
;;   (if (or pdf-view-continuous (null arg))
;;       (let ((hscroll (window-hscroll))
;;             (cur-page (pdf-view-current-page)))
;;         (when (or (= (window-vscroll) (image-scroll-up arg))
;;                   ;; Workaround rounding/off-by-one issues.
;;                   (memq pdf-view-display-size
;;                         '(fit-height fit-page)))
;;           (pdf-view-next-page 2)
;;           (when (/= cur-page (pdf-view-current-page))
;;             (image-bob)
;;             (image-bol 1))
;;           (set-window-hscroll (selected-window) hscroll)))
;;     (image-scroll-up arg)))

;; (defun my-pdf-view-double-scroll-horizontal-view ()
;;   (interactive)
;;   (my-pdf-view-double-scroll-up-or-next-page)
;;   (other-window 1)
;;   (my-pdf-view-double-scroll-up-or-next-page)
;;   (other-window 1))

;; (defun my-pdf-view-double-scroll-vertical-view ()
;;   (interactive)
;;   (my-pdf-view-double-scroll-up-or-next-page)
;;   (shrink-window 1)
;;   (other-window 1)
;;   (my-pdf-view-double-scroll-up-or-next-page)
;;   (enlarge-window 1)
;;   (other-window 1))
;; Pdf (tools):1 ends here

;; [[file:config.org::*Tree sittier][Tree sittier:1]]
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
;; Tree sittier:1 ends here

;; [[file:config.org::*Writeroom mode][Writeroom mode:1]]
(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(add-hook 'writeroom-mode-hook #'(lambda () (text-scale-increase 1)))
;; Writeroom mode:1 ends here

;; [[file:config.org::*mixed pitch mode][mixed pitch mode:1]]
(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "mixed pitch mode" "p" #'mixed-pitch-mode))
;; mixed pitch mode:1 ends here

;; [[file:config.org::*VS code emulation][VS code emulation:1]]
;; comment lines
(define-key global-map (kbd "C-/") #'evilnc-comment-or-uncomment-lines)
;; TODO move lines up/down
;; VS code emulation:1 ends here

;; [[file:config.org::*outline (~lsp-ui-imenu~)][outline (~lsp-ui-imenu~):1]]
(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "lsp-ui-imenu ([o]utline contents)" "o" #'lsp-ui-imenu))
;; outline (~lsp-ui-imenu~):1 ends here

;; [[file:config.org::*Column cutoff ~visual-fill-column~ (better zen/writeroom mode)][Column cutoff ~visual-fill-column~ (better zen/writeroom mode):1]]
(add-hook 'visual-fill-column-mode-hook (setq visual-fill-column-width my-visual-fill-column-width))

(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "visual fill column" "z" #'visual-fill-column-mode))
       ;; :desc "visual fill column" "z" (lambda () (interactive) (setq visual-fill-column-width my-visual-fill-column-width) (#'visual-fill-column-mode))))
;; Column cutoff ~visual-fill-column~ (better zen/writeroom mode):1 ends here

;; [[file:config.org::*git diff fringe(~diff-hl~)][git diff fringe(~diff-hl~):1]]
;;   (global-diff-hl-mode -1) ;; FIXME
(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "git diff-hl fringe" "d" #'diff-hl-mode))
;; git diff fringe(~diff-hl~):1 ends here
