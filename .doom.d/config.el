;; [[file:config.org::*Better Defaults][Better Defaults:1]]
;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Better Defaults:1 ends here

;; [[file:config.org::*Better Defaults][Better Defaults:2]]
(setq auto-save-default t
      initial-major-mode 'org-mode
      make-backup-files t)

;; (menu-bar-mode 1)  ;; good for learning

(setq-default tab-width 2)
(setq straight-allow-recipe-inheritance nil)

;; (pixel-scroll-mode 1) ; smooth scrolling ; ERROR causes severe lag

(setq lisp-indent-offset 2)
;; Better Defaults:2 ends here

;; [[file:config.org::*User Info][User Info:1]]
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")
;; User Info:1 ends here

;; [[file:config.org::*General][General:1]]
(setq-default line-spacing 0.1)

(setq display-line-numbers-type 'relative  ; or `nil'
      +ivy-buffer-preview t                ; preview buffer on switch
      emojify-emoji-set "emojione-v2.2.6"  ; increase resolution from default "emojione-v2.2.6-22"
      fringe-mode 'default)  ; FIXME

(after! emacs-startup-hook
  fringe-mode 'default
  (global-hl-line-mode -1))  ; dont highlight the line

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode) ; icons in dired

;; Highlight-indent-guide
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character
      highlight-indent-guides-responsive 'stack)

;; Rainbow mode: colorise strings that represent colors
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1)
;; General:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
(setq doom-theme 'my-doom-dark+)
;; TODO highlight src block heads and footers a different color? (without bleed? (end foot early)
;; (setq doom-theme 'my-doom-gruvbox)
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-zenburn)

(setq doom-themes-enable-bold t
      doom-themes-padded-modeline nil)
;; Theme:1 ends here

;; [[file:config.org::*Fonts][Fonts:1]]
;; (use-package! mixed-pitch
;;   :hook (org-mode . mixed-pitch-mode)
;;   :config
;;   (setq variable-pitch-set-heigth 't)
;   (set-face-attribute 'variable-pitch nil :height 1.5))

(setq doom-font (font-spec :family "Hasklug Nerd Font Mono" :size 26 :height 1.0)
;; (setq  doom-font (font-spec :family "Agave Nerd Font Mono")
;; (setq  doom-font (font-spec :family "Cousine Nerd Font Mono" ) ;; TODO size
       doom-variable-pitch-font (font-spec :family "DM Mono")
;;       doom-variable-pitch-font (font-spec :family "Iosevka Aile") ; :size 32 :height 1.5)
;;       doom-variable-pitch-font (font-spec :family "ETBookOT")
;;       doom-variable-pitch-font (font-spec :family "TSCu_Comic")
;;       doom-unicode-font (font-spec :family "Symbola")          ; good unicode support
;;       doom-big-font (font-spec :family "Fira Mono" :size 19))
)
;; Fonts:1 ends here

;; [[file:config.org::*Window Divider][Window Divider:1]]
;; TODO better window divider for emacs in terminal
;; (defun my-change-window-divider ()
;;   (let ((display-table (or buffer-display-table standard-display-table)))
;;     (set-display-table-slot display-table 5 ?│)
;;     (set-window-display-table (selected-window) display-table)))

;; (add-hook 'window-configuration-change-hook 'my-change-window-divider)
;; Window Divider:1 ends here

;; [[file:config.org::*Modeline][Modeline:1]]
;; TODO minibuffer modeline + centaur (vscode-esque)

;; (custom-set-faces!
;;     '(mode-line :family "Iosevka Aile")  ; :height 0.85)
;;     '(mode-line-inactive :family "Iosevka Aile"))  ; :height 0.85))

(setq doom-modeline-height 10
      doom-modeline-indent-info t
      doom-modeline-vcs-max-length 12
      doom-modeline-buffer-file-name-style 'truncate-all
      doom-modeline-icon t
      doom-modeline-major-mode-icon t)

;; (defcustom doom-modeline-hud nil)

;; (setq mini-modeline-mode t)
;; (use-package mini-modeline
;;   :after doom-modeline
;;   :config
;;   (mini-modeline-mode t))

;; 2nd shot ...
;; (use-package eldoc-eval)
;; (use-package doom-modeline
;;   ;; :demand t
;;   ;; :custom
;;   ;; (doom-modeline-buffer-file-name-style 'truncate-all)
;;   ;; (doom-modeline-bar-width (frame-parameter nil 'left-fringe))
;;   ;; (doom-modeline-height 10)
;;   ;; (doom-modeline-icon t)
;;   ;; (doom-modeline-icons-scale-factor 0.8)
;;   ;; :config
;;   ;; (set-face-attribute 'doom-modeline nil :inherit 'default)
;;   ;; (set-face-attribute 'doom-modeline-inactive nil :inherit 'default)
;;   )

;; (setq doom-modeline-height 10
;;    doom-modeline-buffer-file-name-style 'truncate-all
;;    doom-modeline-bar-width (frame-parameter nil 'left-fringe)
;;    doom-modeline-height 10
;;    doom-modeline-icon nil
;;    ;; doom-modeline-icons-scale-factor 0.8
;; )

;; (use-package mini-modeline
;;   :after doom-modeline
;;   :config
;;   (doom-modeline-def-modeline 'minibuffer-line
;;     '(modals workspace-name window-number matches buffer-info remote-host buffer-position word-count selection-info misc-info major-mode process vcs lsp checker))

;;   ;; (setq mini-modeline-r-format '(:eval (doom-modeline-format--minibuffer-line)))

;;   (setq mini-modeline-right-padding 1
;;         mini-modeline-enhance-visual nil)

;;   (set-face-attribute 'mode-line nil :box nil)
;;   (set-face-attribute 'mini-modeline-mode-line nil :background (face-background 'org-code) :height 0.2)
;;   (set-face-attribute 'mini-modeline-mode-line-inactive nil :background (face-background 'fringe) :height 0.2)

;;   :hook (after-init . mini-modeline-mode)
;;   )
;; Modeline:1 ends here

;; [[file:config.org::*UPDATE scroll bar (yascroll)][UPDATE scroll bar (yascroll):1]]
(global-yascroll-bar-mode 1)
(setq yascroll-scroll-bar "right-fringe")

;; FIXME disapperaing when not moving
;; TODO increase default fringe width
;; UPDATE scroll bar (yascroll):1 ends here

;; [[file:config.org::*Which key][Which key:1]]
;; NOTE i dont really understand...
(after! which-key
(pushnew!
  which-key-replacement-alist
  '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
  '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
  ))
;; Which key:1 ends here

;; [[file:config.org::*Completion][Completion:1]]
(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(setq company-show-numbers t  ; M-N to use
      company-idle-delay 0)

;; company-math (latex unicode completions)
(add-to-list 'company-backends 'company-math-symbols-unicode)
(setq company-math-allow-latex-symbols-in-faces  t) ;; allow completion in org-mode text

;; TabNine (AI autocomplete)
(require 'company-tabnine)
(add-to-list 'company-backends 'company-tabnine)
;; Completion:1 ends here

;; [[file:config.org::*General][General:1]]
(after! org
  (add-hook! 'org-mode-hook #'+org-pretty-mode   ; hides emphasis markers and toggles "pretty entities"
                            #'org-appear-mode    ; expand invisible emphasis markers etc.
                            #'mixed-pitch-mode)  ; uses var-pitch font for text

  (setq org-directory "~/org"              ; dir for agenda etc.
        org-num-skip-unnumbered t          ; skip `:UNNUMBERED:` from numbering
        org-ellipsis "  "
        display-line-numbers-type 'nil
        ;; hl-line-mode 'nil                  ; FIXME saw a forum saying this is broken
        org-startup-with-inline-images 't  ; TODO check if working
        ;; org-image-actual-width 450         ; set default width ; FIXME overrides setting inline
        org-startup-with-latex-preview 't
        org-startup-shrink-all-tables 't
        org-appear-autolinks 't            ; auto appear links
        org-startup-indented 'nil            ; dont indent paragraphs
        org-appear-autosubmarkers 't       ; auto apear subscript/superscript
        org-appear-autoentities 't         ; auto apear \alpha etc.
        org-appear-autokeywords 't         ; auto apear elements in `org-hidden-keywords'

        org-startup-folded 't))            ; FIXME not working

(require 'org-superstar)  ; NEEDED?
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([+]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))

;; (setq org-blank-before-new-entry
;;   '((heading . t) (plain-list-item . t)))
;; General:1 ends here

;; [[file:config.org::*Headings][Headings:1]]
;; TODO increase sizes?
;; line weights: normal, semi-bold, bold
(custom-set-faces!
  '(outline-1 :weight normal :height 1.24) ;1.12)
  '(outline-2 :weight normal :height 1.16) ;1.08)
  '(outline-3 :weight normal :height 1.10) ;1.05)
  '(outline-4 :weight normal :height 1.06) ;1.03)
  '(outline-5 :weight normal :height 1.04) ; 1.02
  '(outline-6 :weight normal :height 1.02) ;1.01)
  '(outline-7 :weight normal)
  '(outline-8 :weight normal)
  '(org-document-title :weight normal :height 1.8)) ; 1.2


;; Superstar symbols
(after! org-superstar
  (setq org-superstar-headline-bullets-list '( "◉" "○" "⎊" "⎉" "⊛" "⊚" "◦" "◘")
  ;; (setq org-superstar-headline-bullets-list '("①" "②" "✸" "✿" "✤" "✜" "◆" "") ;; double circle bullet...
        org-superstar-prettify-item-bullets t ))
;; Headings:1 ends here

;; [[file:config.org::*To-do's][To-do's:1]]
(setq org-todo-keywords '(
  (sequence "TODO(t)" "DOING(d)" "STRT(s)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "MAYBE(m)" "ERROR(e)" "FIXME(f)" "UPDATE(u)" "MOVE(M)" "(x)" "|" "DONE(D)" "CANCL(c)" "DEPRECATED(E)")
  (sequence "[ ](T)" "[-](-)" "[?](?)" "|" "[X](X)" "[.](.)" )
  (sequence "|" "OKAY(o)" "YES(y)" "NO(N)")
))

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
  ;; ("DONE" . (:foreground "" :Weight bold))
  ("CANCL" . (:foreground "grey11" :weight semi-bold +org-todo-cancel))
  ("[-]" . +org-todo-active)
  ("[?]" . +org-todo-onhold)
  ("YES" . (:foreground "DarkSeaGreen3"))
  ("NO" . +org-todo-cancel)
))
;; To-do's:1 ends here

;; [[file:config.org::*Tags][Tags:1]]
(setq org-tag-persistent-alist
      '((:startgroup . nil)
        ("uni" . ?u)
        ("computing" . ?c)
        ("graph_theory" . ?g)
        ("math" . ?m)
        ("philosophy" . ?p)
        ("phychology" . ?P)
        ("research" . ?r)
        ("my" . ?m)
        ("money" . ?M)
        (:endgroup . nil)
        ("noexport" . ?x)
))
;; Tags:1 ends here

;; [[file:config.org::*Tables][Tables:1]]
;; (add-hook 'org-mode-hook #'valign-mode)
;; (setq valign-fancy-bar 'non-nil)

(require 'phscroll)

(after! org
 (setq org-startup-truncated nil)
 (load "org-phscroll.el"))
;; Tables:1 ends here

;; [[file:config.org::*Prettify symbols][Prettify symbols:1]]
;; FIXME Not working..
(setq prettify-symbols-alist
  (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
          '(("#+begin_src" . )
            ("#+end_src" . ?)
            ("#+begin_example" . ?)
            ("#+end_example" . ?)
            ("#+header:" . ?)
            ("#+name:" . ?﮸)
            ("#+results:" . ?)
            ("#+call:" . )
            (":properties:" . ?)
            (":logbook:" . ?))))
;; Prettify symbols:1 ends here

;; [[file:config.org::*Org-Babel (src blocks)][Org-Babel (src blocks):1]]
;; typescript
(org-babel-do-load-languages
  'org-babel-load-languages
    '((C. t)
      (dot . t)
      (haskell . t)
      (js . t)
      (json . t)
      (nix . t)
      (python . t)
      ;; (sh . t)
      (typescript . t)
      ;; jupyter must be load last
      (jupyter . t)))

(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

;; (defalias 'org-babel-execute:ts 'org-babel-execute:typescript) ; FIXME
;; Org-Babel (src blocks):1 ends here

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

;; [[file:config.org::*HTML Export][HTML Export:1]]
(setq org-html-html5-fancy t
      org-html-table-caption-above nil
      org-html-htmlize-output-type 'inline-css)
      ;; org-html-htmlize-output-type 'css)

;; (setq org-confirm-babel-evaluate nil)

;; FIXME: prevent oversize svg img widths on org html export
;; (with-eval-after-load 'ox-html
;;   (setq org-html-head
;;         (replace-regexp-in-string
;;          ".org-svg { width: 90%; }"
;;          ".org-svg { width: auto; }"
;;          org-html-style-default)))
;; HTML Export:1 ends here

;; [[file:config.org::*Latex Export][Latex Export:1]]
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
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
;; (eval-after-load 'org
;;   '
(setq org-highlight-latex-and-related '(native script entities))
;; )

;; prevent background redering uglyness
;; OLD: https://stackoverflow.com/questions/69474043/emacs-org-mode-background-color-of-latex-fragments-with-org-highlight-latex-a
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

;; Automatically load inline previews with org-fragtog
(add-hook 'org-mode-hook 'org-fragtog-mode)

;; Color transparentrather than match default face
(setq org-format-latex-options
      (plist-put org-format-latex-options :background "Transparent"))


                ;; specify the justification you want
(plist-put org-format-latex-options :justify 'center)
;; Latex fragments:1 ends here

;; [[file:config.org::*Org Cite][Org Cite:1]]
;; (setq org-cite-global-bibliography "~/org/roam/Zotero/bibliography.bib")
;; Org Cite:1 ends here

;; [[file:config.org::*DEPRECATED Org-ref][DEPRECATED Org-ref:1]]
;; FIXME startup error
;; (require 'doi-utils)

;; (setq reftex-default-bibliography '("~/org/roam/bibliography.bib"))

;; ;; see org-ref for use of these variables
;; (setq org-ref-default-bibliography '("~/org/roam/PDFs/bibliography.bib")
;;       org-ref-bibliography-notes "~/org/roam/PDFs"   ; TODO not in use
;;       org-ref-pdf-directory "~/org/roam/PDFs/"       ; academic papers
;;       org-ref-completion-library 'org-ref-ivy-cite
;;       org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
;;       org-ref-bibliography-notes "~/org/roam/PDFs"
;;       org-ref-notes-directory "~/org/roam/PDFs"
;;       org-ref-notes-function 'orb-edit-notes)
;; DEPRECATED Org-ref:1 ends here

;; [[file:config.org::*Helm-bibtex][Helm-bibtex:1]]
(after! org
    (setq bibtex-completion-bibliography "~/org/roam/Zotero/bibliography.bib"
          bibtex-completion-library-path "~/org/roam/Zotero/storage/."
          bibtex-completion-notes-path "~/org/roam/Zotero/storage"))

;; (after! org
;;     (setq bibtex-completion-bibliography "~/org/roam/PDFs/bibliography.bib"
;;           bibtex-completion-library-path "~/org/roam/PDFs/"
;;           bibtex-completion-notes-path "~/org/roam/PDFs"))
;; Helm-bibtex:1 ends here

;; [[file:config.org::*UPDATE emacs-jupyter][UPDATE emacs-jupyter:1]]
; this seems to add syntax-highlighting to jupyter-python and jupyter-typescript blocks
;; (after! org-src
;;   (dolist (lang '(python typescript jupyter))
;;   (cl-pushnew (cons (format "jupyter-%s" lang) lang)
;;                 org-src-lang-modes :key #'car))

;;   ;;(org-babel-jupyter-override-src-block "python") ;; alias all python to jupyter-python
;;   ;;(org-babel-jupyter-override-src-block "typescript") ;; alias all python to jupyter-python
;;  )

;; TypeScript
;; (setq org-babel-default-header-args:jupyter-typescript '(
;;   (:session . "ts")
;;   (:kernel . "tslab")))

;; Python
(setq org-babel-default-header-args:jupyter-python '(
   (:session . "py")
   ;; (:pandoc . "t")
   (:kernel . "python")))

;; Haskell
(setq org-babel-default-header-args:jupyter-haskell '(
   (:session . "hs")
   (:kernel . "haskell")))
;; UPDATE emacs-jupyter:1 ends here

;; [[file:config.org::*Org-noter][Org-noter:1]]
(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-always-create-frame nil))  ; stop opening frames

;; (setq org-noter-set-notes-window-location
;; Org-noter:1 ends here

;; [[file:config.org::*Hypothesis][Hypothesis:1]]
(setq hypothesis-username "nazzacode"
      hypothesis-token "6879-DJYjeV3gat2emzWKlSGkQu20tQTvQK3s7xVSepSdjfA")
;; Hypothesis:1 ends here

;; [[file:config.org::*FIXME org-download][FIXME org-download:1]]
(require 'org-download)
(setq org-download-screenshot-method "xclip")
(setq-default org-download-image-dir "~/org/roam/Images")

  ;; (use-package org-download
  ;; :after org
  ;; :bind
  ;; (:map org-mode-map
  ;;       (("a-Y" . org-download-screenshot)
  ;;        ("a-y" . org-download-yank)))
;; FIXME org-download:1 ends here

;; [[file:config.org::*General][General:1]]
;; (add-hook 'after-init-hook 'org-roam-setup)   ; FIXME start on start-up BREAKING CONFIG ON REDOWNLOAD
(setq org-roam-directory "~/org/roam"       ; set org-roam dir
      +org-roam-open-buffer-on-find-file nil
)
;; General:1 ends here

;; [[file:config.org::*Org Roam Capture Templates][Org Roam Capture Templates:1]]
(setq org-roam-capture-templates

;; Default
  `(("d" "default" plain "%?"
    :if-new (file+head "${slug}.org"

"#+title: ${title}
#+filetags:\n")

    :unnarrowed t)

;; Code Challange
  ("c" "Code Challange" plain "%?"
    :if-new (file+head "CodeChallanges/${slug}.org"

":PROPERTIES:
:Source:
:Difficulty:
:Rating:
:END:
#+title: ${title}
#+filetags: :code-challange:

\n* Question
\n** Example
~Input: ~
~Output: ~

\n* [ ] Solution
\n* Testing
\n* Runtime Analysis")

    :unnarrowed t)

;; Debug/Troubleshoot
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

    :unnarrowed t)
  )
)
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

;; [[file:config.org::*Org-roam-bibtex (ORB)][Org-roam-bibtex (ORB):1]]
(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)) ; optional: if Org Ref is not loaded anywhere else, load it here

;;   (setq orb-preformat-keywords
;;       '("citekey" "title" "url" "author-or-editor" "keywords" "file")
;;       orb-process-file-keyword t
;;       orb-file-field-extensions '("pdf"))
;;   ;; (setq orb-preformat-keywords
;;   ;; '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
;;   (setq orb-templates
;;     '(("r" "ref" plain (function org-roam-fapture--get-point)
;;      ""
;;      :file-name "${slug}"
;;      :head "#+TITLE: ${citekey}: ${title}\n#+roam_key: ${ref}\n#+roam_tags:

;; - keywords :: ${keywords}

;; \n* ${title}
;; :PROPERTIES:
;; :Custom_ID: ${citekey}
;; :URL: ${url}
;; :AUTHOR: ${author-or-editor}
;; :NOTER_DOCUMENT: ${file}
;; :NOTER_PAGE:
;; :END:"
;;      :unnarrowed t))))
;; Org-roam-bibtex (ORB):1 ends here

;; [[file:config.org::*UPDATE org-roam-ui][UPDATE org-roam-ui:1]]
(use-package! websocket
    :after org-roam)

;; (use-package! org-roam-ui
;;     :after org-roam ;; or :after org
;; ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; ;;         a hookable mode anymore, you're advised to pick something yourself
;; ;;         if you don't care about startup time, use
;;     ;; :hook (after-init . org-roam-ui-mode)
;;     :config
;;     (setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start t))

(setq org-roam-ui-sync-theme t
      org-roam-ui-follow t
      org-roam-ui-update-on-save t
      org-roam-ui-open-on-start t)
;; UPDATE org-roam-ui:1 ends here

;; [[file:config.org::*peep-dired][peep-dired:1]]
(setq peep-dired-cleanup-eagerly t)
(setq peep-dired-enable-on-directories t)

(evil-define-key 'normal peep-dired-mode-map (kbd "<SPC>") 'peep-dired-scroll-page-down
                                             (kbd "C-<SPC>") 'peep-dired-scroll-page-up
                                             (kbd "<backspace>") 'peep-dired-scroll-page-up
                                             (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(setq peep-dired-ignored-extensions '("mkv" "iso" "mp4"))
;; peep-dired:1 ends here

;; [[file:config.org::*Agenda][Agenda:1]]
;; (custom-set-variables '(org-agenda-files (list "~/org/roam/gcal.org")))
 (setq org-agenda-files '("~/org/roam/gcal.org"))
;; Agenda:1 ends here

;; [[file:config.org::*Clean category column garbage][Clean category column garbage:1]]
(setq org-agenda-prefix-format
      '((agenda . " %i %-12(vulpea-agenda-category)%?-12t% s")
        (todo . " %i %-12(vulpea-agenda-category) ")
        (tags . " %i %-12(vulpea-agenda-category) ")
        (search . " %i %-12(vaulpea-agenda-category) ")))

(defun vulpea-agenda-category ()
  "Get category of item at point for agenda.

Category is defined by one of the following items:

- CATEGORY property
- TITLE keyword
- TITLE property
- filename without directory and extension

Usage example:

  (setq org-agenda-prefix-format
        '((agenda . \" %(vulpea-agenda-category) %?-12t %12s\")))

Refer to `org-agenda-prefix-format' for more information."
  (let* ((file-name (when buffer-file-name
                      (file-name-sans-extension
                       (file-name-nondirectory buffer-file-name))))
         (title (vulpea-buffer-prop-get "title"))
         (category (org-get-category)))
    (or (if (and
             title
             (string-equal category file-name))
            title
          category)
        "")))

(defun vulpea-buffer-prop-get (name)
  "Get a buffer property called NAME as a string."
  (org-with-point-at 1
    (when (re-search-forward (concat "^#\\+" name ": \\(.*\\)")
                             (point-max) t)
      (buffer-substring-no-properties
       (match-beginning 1)
       (match-end 1)))))
;; Clean category column garbage:1 ends here

;; [[file:config.org::*Writeroom Mode][Writeroom Mode:1]]
;; TODO increase font less
;;(setq writeroom-mode-line t)
;; Writeroom Mode:1 ends here

;; [[file:config.org::*Calendar][Calendar:1]]
;; gcal integration
(require 'calfw)
(require 'org-gcal)

(setq org-gcal-client-id "189857002612-bei34shug7gu4ft5ssi5mfedl1kb50u2.apps.googleusercontent.com"
      org-gcal-client-secret "jMCbPjcHaUWrGu02yUVwIi1m"
      org-gcal-fetch-file-alist '(("nathansharp03@gmail.com" .  "~/org/roam/gcal.org")))

                                  ;; ("another-mail@gmail.com" .  "~/task.org")))
;; NOTE: requires gpg (gnupg)

;; Pull into single calender
;; (require 'calfw-cal)
(require 'calfw-ical)
;;(require 'calfw-howm)
(require 'calfw-org)

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source  )  ; orgmode source
    ;; (cfw:cal-create-source "Orange") ; diary source
    ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
    ;; ↓ google calendar ICS
    ;; (cfw:ical-create-source "gcal"
      ;; "https://calendar.google.com/calendar/ical/nathansharp03%40gmail.com/private-5984779a038e5ab68ee283c744922c8a/basic.ics"
      ;; "#339CDB")
)))

(setq package-check-signature nil)

;; duplication of defualt behavior
;; TODO on startup?
;; (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
;; (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))
;; Calendar:1 ends here

;; [[file:config.org::*Latex][Latex:1]]
(setq org-format-latex-options
  (list
        :foreground 'default  ;; or `auto'
        ;; :background 'auto
        :scale 2.8  ;; bigger latex fragment
        ;; :html-foreground "Black"
        ;; :html-background "Transparent"
        ;; :html-scale 1.0
        :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))
;; Latex:1 ends here

;; [[file:config.org::*Exporting][Exporting:1]]
(setq org-export-headline-levels 5) ; I like nesting

;; show git version on creator string
(setq org-export-creator-string
      (format "Emacs %s (Org mode %s %s)" emacs-version (org-release) (org-git-version)))
;; Exporting:1 ends here

;; [[file:config.org::*Typescript][Typescript:1]]
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-completion-detailed t)
;; Typescript:1 ends here

;; [[file:config.org::*Treemacs][Treemacs:1]]
;; (after! treemacs
;;   (setq doom-themes-treemacs-enable-variable-pitch nil)) ; TODO try '
;; Treemacs:1 ends here

;; [[file:config.org::*Pdf (tools)][Pdf (tools):1]]
;; more fine-grained zooming
(setq pdf-view-resize-factor 1.1)

;; Double page spread
(defun my-pdf-view-double-scroll-up-or-next-page (&optional arg)
  "Scroll page up ARG lines if possible, else go to the next page.

When `pdf-view-continuous' is non-nil, scrolling upward at the
bottom edge of the page moves to the next page.  Otherwise, go to
next page only on typing SPC (ARG is nil)."
  (interactive "P")
  (if (or pdf-view-continuous (null arg))
      (let ((hscroll (window-hscroll))
            (cur-page (pdf-view-current-page)))
        (when (or (= (window-vscroll) (image-scroll-up arg))
                  ;; Workaround rounding/off-by-one issues.
                  (memq pdf-view-display-size
                        '(fit-height fit-page)))
          (pdf-view-next-page 2)
          (when (/= cur-page (pdf-view-current-page))
            (image-bob)
            (image-bol 1))
          (set-window-hscroll (selected-window) hscroll)))
    (image-scroll-up arg)))

(defun my-pdf-view-double-scroll-horizontal-view ()
  (interactive)
  (my-pdf-view-double-scroll-up-or-next-page)
  (other-window 1)
  (my-pdf-view-double-scroll-up-or-next-page)
  (other-window 1))

(defun my-pdf-view-double-scroll-vertical-view ()
  (interactive)
  (my-pdf-view-double-scroll-up-or-next-page)
  (shrink-window 1)
  (other-window 1)
  (my-pdf-view-double-scroll-up-or-next-page)
  (enlarge-window 1)
  (other-window 1))
;; Pdf (tools):1 ends here

;; [[file:config.org::*Nov.el][Nov.el:1]]
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; Font
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                                           :height 1.0))
(add-hook 'nov-mode-hook 'my-nov-font-setup)


(setq nov-text-width t)
(setq visual-fill-column-center-text t)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)

;; Justified Text
;; ERROR causing chaos with org-noter
(require 'justify-kp)
;; (defun my-nov-window-configuration-change-hook ()
;;   (my-nov-post-html-render-hook)
;;   (remove-hook 'window-configuration-change-hook
;;                'my-nov-window-configuration-change-hook
;;                t))

;; (defun my-nov-post-html-render-hook ()
;;   (if (get-buffer-window)
;;       (let ((max-width (pj-line-width))
;;             buffer-read-only)
;;         (save-excursion
;;           (goto-char (point-min))
;;           (while (not (eobp))
;;             (when (not (looking-at "^[[:space:]]*$"))
;;               (goto-char (line-end-position))
;;               (when (> (shr-pixel-column) max-width)
;;                 (goto-char (line-beginning-position))
;;                 (pj-justify)))
;;             (forward-line 1))))
;;     (add-hook 'window-configuration-change-hook
;;               'my-nov-window-configuration-change-hook
;;               nil t)))

;; (add-hook 'nov-post-html-render-hook 'my-nov-post-html-render-hook)
;; Nov.el:1 ends here

;; [[file:config.org::*MAYBE Direnv (Nix)][MAYBE Direnv (Nix):1]]
;; (use-package direnv
;;  :config
;;  (direnv-mode))
;; MAYBE Direnv (Nix):1 ends here

;; [[file:config.org::*MAYBE Deft][MAYBE Deft:1]]
(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory org-roam-directory))
;; MAYBE Deft:1 ends here

;; [[file:config.org::*Graphviz (dot)][Graphviz (dot):1]]
(use-package! graphviz-dot-mode
  :commands graphviz-dot-mode
  :mode ("\\.dot\\'" "\\.gz\\'")
  ;; correct higlighting in org mode
  :init
  (after! org
    (setcdr (assoc "dot" org-src-lang-modes)
            'graphviz-dot)))

;; ;; TODO Completions
;; (use-package! company-graphviz-dot
;;   :after graphviz-dot-mode)
;; Graphviz (dot):1 ends here
