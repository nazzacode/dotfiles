;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq auto-save-default t
      make-backup-files t)

(setq doom-theme 'doom-gruvbox)
;; TODO customise my own theme
;; TODO easy switch to light theme!

;; `doom-font` and 'variable-pitch' are the important ones!
(setq doom-font (font-spec :family "Agave Nerd Font Mono")
;;      doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
;;      doom-big-font (font-spec :family "Fira Mono" :size 19))
      doom-variable-pitch-font (font-spec :family "ETBookOT"))  ; inherits `doom-font''s :size

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative
      header-line-format " ")  ;; header padding
;; TODO Side padding

(setq doom-modeline-height 15)

;; (setq doom-modeline-major-mode-color-icon nil  ;; FIXME not working :(
;;        all-the-icons-color-icons nil)

;; (setq doom-modeline-height 1)
;; (set-face-attribute 'mode-line nil :family "Agave Nerd Font Mono" :height 100)
;;  (set-face-attribute 'mode-line-inactive nil :family "Noto Sans" :height 100)

(after! org

  (add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)
  (add-hook! 'org-mode-hook 'org-num-mode) ; latex style numbered headings

  (setq org-directory "~/org/"        ; important emacs directory for things like agenda
        org-pretty-entities t         ; unicode/emoji rendering etc.
        org-num-skip-unnumbered t     ; skip `:UNNUMBERED:` from onumbering
        org-ellipsis "  "
        org-hide-emphasis-markers t   ; hide bold, italics etc...
        global-org-pretty-table-mode t
        display-line-numbers-type 'nil
        org-fontify-whole-heading-line t  ; ?
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        hl-line-mode nil
  )
)

  ;; (add-hook! 'org-mode-hook 'org-superstar-mode)  ; fancy unicode symbols (e.g headings)

(custom-set-faces!
  '(outline-1 :weight semi-bold      :height 1.12)
  '(outline-2 :weight semi-bold      :height 1.08)
  '(outline-3 :weight semi-bold      :height 1.05)
  '(outline-4 :weight semi-bold      :height 1.03)
  '(outline-5 :weight normal         :height 1.02)
  '(outline-6 :weight normal         :height 1.01)
  '(outline-7 :weight normal)
  '(outline-8 :weight normal)
  '(org-document-title :height 1.2))

;; (after! haskell-mode
;;  (set-ligatures! haskell-mode
;;  :lambda "\"
;;  )
;;)

(add-to-list 'exec-path "path/to/sqlite3")

(setq org-roam-directory "~/org-roam")  ; set org-roam dir

(add-hook 'after-init-hook 'org-roam-mode) ; start on start-up

(setq org-roam-tag-sources '(prop vanilla all-directories))

(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref) ; optional: if Org Ref is not loaded anywhere else, load it here

  (setq orb-preformat-keywords
      '("citekey" "title" "url" "author-or-editor" "keywords" "file")
      orb-process-file-keyword t
      orb-file-field-extensions '("pdf"))
  ;; (setq orb-preformat-keywords
  ;; '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
    (setq orb-templates
            '(("r" "ref" plain (function org-roam-capture--get-point)
            ""
            :file-name "${slug}"
            :head "#+TITLE: ${citekey}: ${title}\n#+roam_key: ${ref}\n#+roam_tags:

- keywords :: ${keywords}

\n* ${title}
:PROPERTIES:
:Custom_ID: ${citekey}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: ${file}
:NOTER_PAGE:
:END:"
     :unnarrowed t))))

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   ;; org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   ;; org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   ;; org-noter-notes-search-path (list org_notes)
   )
  )

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; TODO is this needed?
;;(add-to-list 'org-latex-packages-alist '("" "natbib"))
;;(add-to-list 'org-latex-packages-alist '("" "cleveref"))

;; Latex Fragments in orgmode
(setq org-format-latex-options
        (list :foreground 'default  ;;auto
              :background 'auto
              :scale 2.2              ;; bigger latex fragments
              :html-foreground "Black"
              :html-background "Transparent"
              :html-scale 1.0
              :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))

(map! "C-q"  ; example
      (cmd! (previous-line)
            (kill-line)
            (forward-line)))

(map! "M-o" (cmd! (org-noter-insert-note)))  ;; TODO map only in noter

;; TODO natural window resizing

(setq lisp-indent-offset 2)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; For GPG configuration, email clients, file templates and snippets.
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")

(require 'doi-utils)
;; TODO ^ do for others?

(setq reftex-default-bibliography '("~/org-roam/bibliography.bib"))

;; see org-ref for use of these variables
(setq org-ref-default-bibliography '("~/org-roam/bibliography.bib")
      org-ref-bibliography-notes "~/org-roam/"   ; TODO not in use
      org-ref-pdf-directory "~/org-roam/PDFs/"
      org-ref-completion-library 'org-ref-ivy-cite
      org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
      org-ref-bibliography-notes "~/org-roam"
      org-ref-notes-directory "~/org-roam"
      org-ref-notes-function 'orb-edit-notes)

(after! org
    (setq bibtex-completion-bibliography "~/org-roam/bibliography.bib"
          bibtex-completion-library-path "~/org-roam/PDFs/"
          bibtex-completion-notes-path "~/org-roam/"))
