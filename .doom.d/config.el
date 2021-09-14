;; [[file:config.org::*Magic Incantation][Magic Incantation:1]]
;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Magic Incantation:1 ends here

;; [[file:config.org::*User Info][User Info:1]]
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")
;; User Info:1 ends here

;; [[file:config.org::*Better Defaults][Better Defaults:1]]
(setq auto-save-default t
      make-backup-files t
      tab-width 2)

(setq-default tab-width 2)
;; Better Defaults:1 ends here

;; [[file:config.org::*UI][UI:1]]
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)      ; icons in dired

;; highlight-indent-guide
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (add-hook 'org-mode-hook 'highlight-indent-guides-mode) ; FIXME background color

(setq highlight-indent-guides-method 'character
      highlight-indent-guides-responsive 'stack)

(setq display-line-numbers-type 'relative  ; or `nil'
      +ivy-buffer-preview t                ; preview buffer on switch
      emojify-emoji-set "emojione-v2.2.6")  ; increase resolution from default "emojione-v2.2.6-22"

;; Rainbow mode :: colorise strings that represent colors
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))

(global-rainbow-mode 1)
;; UI:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
(setq doom-theme 'my-doom-dark+)
;; Theme:1 ends here

;; [[file:config.org::*Fonts][Fonts:1]]
;; (use-package! mixed-pitch
;;   :hook (org-mode . mixed-pitch-mode)
;;   :config
;;   (setq variable-pitch-set-heigth 't)
;;   (set-face-attribute 'variable-pitch nil :height 1.5))

;; (setq doom-font (font-spec :family "Hasklug Nerd Font Mono") ;  :size 26 :height 1.0)     ; Agave Nerd Font Mono
;;       doom-variable-pitch-font (font-spec :family "Iosevka Aile") ; :size 32 :height 1.5)  ; ETBookOT
;;       doom-unicode-font (font-spec :family "Symbola")          ; good unicode support
;;       ;; doom-big-font (font-spec :family "Fira Mono" :size 19))
;;       ;; doom-variable-pitch-font (font-spec :family "TSCu_Comic")
;;)
;; Fonts:1 ends here

;; [[file:config.org::*Window Divider][Window Divider:1]]
;; (defun my-change-window-divider ()
;;   (let ((display-table (or buffer-display-table standard-display-table)))
;;     (set-display-table-slot display-table 5 ?│)
;;     (set-window-display-table (selected-window) display-table)))

;; (add-hook 'window-configuration-change-hook 'my-change-window-divider)
;; Window Divider:1 ends here

;; [[file:config.org::*Modeline][Modeline:1]]
;; TODO minibuffer modeline + centaur

;; (custom-set-faces!
;;     '(mode-line :family "Iosevka Aile")  ; :height 0.85)
;;     '(mode-line-inactive :family "Iosevka Aile"))  ; :height 0.85))

;; (setq doom-modeline-height 90)
;; Modeline:1 ends here

;; [[file:config.org::*Writeroom Mode][Writeroom Mode:1]]
;; TODO increase font less
;;(setq writeroom-mode-line t)
;; Writeroom Mode:1 ends here

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
        org-startup-with-latex-preview 't
        org-startup-shrink-all-tables 't
        org-startup-folded 't))            ; FIXME not working

(require 'org-superstar)  ; NEEDED?

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
;; General:1 ends here

;; [[file:config.org::*Headings][Headings:1]]
;; TODO increase sizes?
(custom-set-faces!
  '(outline-1 :weight semi-bold  :height 1.24) ;1.12)
  '(outline-2 :weight semi-bold  :height 1.16) ;1.08)
  '(outline-3 :weight semi-bold  :height 1.10) ;1.05)
  '(outline-4 :weight semi-bold  :height 1.06) ;1.03)
  '(outline-5 :weight normal     :height 1.04) ; 1.02
  '(outline-6 :weight normal     :height 1.02) ;1.01)
  '(outline-7 :weight normal)
  '(outline-8 :weight normal)
  '(org-document-title :height 1.4)) ; 1.2
;; Headings:1 ends here

;; [[file:config.org::*Todo's][Todo's:1]]
(setq org-todo-keywords '(
  (sequence "TODO(t)" "DOING(d)" "STRT(s)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "MAYBE(m)" "ERROR(e)" "FIXME(f)" "|" "DONE(D)" "CANCL(c)")
  (sequence "[ ](T)" "[-](-)" "[?](?)" "|" "[X](x)")
  (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")
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
  ("NO" . +org-todo-cancel)
))
;; Todo's:1 ends here

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
(add-hook 'org-mode-hook #'valign-mode)
(setq valign-fancy-bar 'non-nil)
;; Tables:1 ends here

;; [[file:config.org::*Org-roam][Org-roam:1]]
;; (add-hook 'after-init-hook 'org-roam-setup)   ; FIXME start on start-up BREAKING CONFIG ON REDOWNLOAD
(setq org-roam-directory "~/org/roam"       ; set org-roam dir
      +org-roam-open-buffer-on-find-file nil
)
;; Org-roam:1 ends here

;; [[file:config.org::*Org Roam Capture Templates][Org Roam Capture Templates:1]]
(setq org-roam-capture-templates

;; Default
  `(("d" "default" plain "%?"
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"

"#+title: ${title}
#+filetags:\n")

    :unnarrowed t)

;; Code Challange
  ("c" "Code Challange" plain "%?"
    :if-new (file+head "CodeChallanges/%<%Y%m%d%H%M%S>-${slug}.org"

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

\n* TODO Solution
\n* Testing
\n* Runtime Analysis")

    :unnarrowed t)

;; Debug/Troubleshoot
  ("D" "Debug/Error/Fix-me" plain "%?"
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"

"#+title: ${title}
#+filetags: :debug:

\n* Problem
\n* TODO Solution")

    :unnarrowed t)

;; Cheatsheet
  ("C" "cheatsheet" plain "%?"
    :if-new (file+head "cheatsheets/%<%Y%m%d%H%M%S>-${slug}.org"

"#+title: ${title}
#+filetags: :cheatsheat:\n

| Command | Description |
|---------+-------------|
|         |             |")

    :unnarrowed t)

;; Todo (Kanban)
  ("t" "Todo/Kanban" plain "%?"
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"

"#+title: ${title}
#+filetags: :todo:
#+startup: show2levels

\n* Doing
\n* Todo
\n* Done")

    :unnarrowed t)
  )
)
;; Org Roam Capture Templates:1 ends here

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

;; [[file:config.org::*Hiding the Properties Drawer][Hiding the Properties Drawer:1]]
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
;; Hiding the Properties Drawer:1 ends here

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

;; [[file:config.org::*Org-Babel (src blocks)][Org-Babel (src blocks):1]]
;; typescript
(org-babel-do-load-languages
  'org-babel-load-languages
    '((typescript . t)
      (nix . t)
      (python . t)
      ;; (sh . t)
      ;; (js . t)
      (jupyter . t)))

(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

;; (defalias 'org-babel-execute:ts 'org-babel-execute:typescript) ; FIXME
;; Org-Babel (src blocks):1 ends here

;; [[file:config.org::*Jupyter][Jupyter:1]]
; this seems to add syntax-highlighting to jupyter-python and jupyter-typescript blocks
(after! org-src
  (dolist (lang '(python typescript jupyter))
  (cl-pushnew (cons (format "jupyter-%s" lang) lang)
                org-src-lang-modes :key #'car))

  ;;(org-babel-jupyter-override-src-block "python") ;; alias all python to jupyter-python
  ;;(org-babel-jupyter-override-src-block "typescript") ;; alias all python to jupyter-python
 )

;; TypeScript
(setq org-babel-default-header-args:jupyter-typescript '(
  (:session . "ts")
  (:kernel . "tslab")))

;; ;; Python
;; (setq org-babel-default-header-args:jupyter-python '(
;;    (:session . "py")
;;    (:kernel . "python")))
;; Jupyter:1 ends here

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

;; [[file:config.org::*Latex][Latex:1]]
;; FIXME Latex fragments in org mode
(setq org-format-latex-options
  (list
;;        :foreground 'default  ;;auto
        ;; :background 'auto
        :scale 3.0              ;; bigger latex fragment
        ;; :html-foreground "Black"
        ;; :html-background "Transparent"
        ;; :html-scale 1.0
        :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))
;; Latex:1 ends here

;; [[file:config.org::*Direnv (Nix)][Direnv (Nix):1]]
(use-package direnv
 :config
 (direnv-mode))
;; Direnv (Nix):1 ends here

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

;; [[file:config.org::*Misc][Misc:1]]
(setq lisp-indent-offset 2)
;; Misc:1 ends here

;; [[file:config.org::*Org-ref][Org-ref:1]]
;; FIXME startup error
(require 'doi-utils)

(setq reftex-default-bibliography '("~/org/roam/bibliography.bib"))

;; see org-ref for use of these variables
(setq org-ref-default-bibliography '("~/org/roam/PDFs/bibliography.bib")
      org-ref-bibliography-notes "~/org/roam/PDFs"   ; TODO not in use
      org-ref-pdf-directory "~/org/roam/PDFs/"       ; academic papers
      org-ref-completion-library 'org-ref-ivy-cite
      org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
      org-ref-bibliography-notes "~/org/roam/PDFs"
      org-ref-notes-directory "~/org/roam/PDFs"
      org-ref-notes-function 'orb-edit-notes)
;; Org-ref:1 ends here

;; [[file:config.org::*Helm-bibtex][Helm-bibtex:1]]
(after! org
    (setq bibtex-completion-bibliography "~/org/roam/PDFs/bibliography.bib"
          bibtex-completion-library-path "~/org/roam/PDFs/"
          bibtex-completion-notes-path "~/org/roam/PDFs"))
;; Helm-bibtex:1 ends here
