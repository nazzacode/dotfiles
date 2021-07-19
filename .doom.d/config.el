;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; For GPG configuration, email clients, file templates and snippets.
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")

(setq auto-save-default t
      make-backup-files t)

(setq display-line-numbers-type 'relative  ; or `nil'
      header-line-format " "              ; header padding
      fringe-mode 'default)

(setq doom-theme 'my-doom-dark+)  ; FIXME Breaks Latex fragments background

;;(setq doom-dark+-padded-modeline nil)

;; (use-package! mixed-pitch
;;   :hook (org-mode . mixed-pitch-mode)
;;   :config
;;   (setq variable-pitch-set-heigth 't)
;;   (set-face-attribute 'variable-pitch nil :height 1.5))

(setq doom-font (font-spec :family "Hasklug Nerd Font Mono") ;  :size 26 :height 1.0)     ; Agave Nerd Font Mono
      doom-variable-pitch-font (font-spec :family "Iosevka Aile") ; :size 32 :height 1.5)  ; ETBookOT
      doom-unicode-font (font-spec :family "Symbola")          ; good unicode support
      ;; doom-big-font (font-spec :family "Fira Mono" :size 19))
      ;; doom-variable-pitch-font (font-spec :family "TSCu_Comic")
)

(custom-set-faces!
    '(mode-line :family "Iosevka Aile")  ; :height 0.85)
    '(mode-line-inactive :family "Iosevka Aile"))  ; :height 0.85))

(setq doom-modeline-height 90)

;; TODO move to top aka `header-line-format'
;; (setq header-line-format mode-line-format)
;; (setq mode-line-format nil)
;; FIXME Not loading on start and breaking writeroom

;; TODO increase font less
;;(setq writeroom-mode-line t)

(setq emojify-emoji-set "emojione-v2.2.6") ; increase resolution from default "emojione-v2.2.6-22"

(add-hook! 'org-mode-hook 'org-appear-mode)

(after! org
  (add-hook! 'org-mode-hook #'+org-pretty-mode
                            #'mixed-pitch-mode)  ; uses var-pitch font for text
  ;; (add-hook! 'org-mode-hook 'org-num-mode)   ; numbered headings
  (setq org-directory "~/org"             ; dir for agenda etc.
        org-num-skip-unnumbered t               ; skip `:UNNUMBERED:` from onumbering
        org-ellipsis "  "
        display-line-numbers-type 'nil
        hl-line-mode 'nil
        org-startup-with-inline-images 't
        org-startup-with-latex-preview 't
        org-startup-shrink-all-tables 't
        org-startup-folded 'fold))

;; Multiline Emphasis
;; FIXME casuing depreciated errors?
;; (setcar (nthcdr 4 org-emphasis-regexp-components) 10)
;;(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

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

;; Typescript
(org-babel-do-load-languages
  'org-babel-load-languages
    '((typescript . t)
      (jupyter . t)))

;; (require 'typescript-mode)
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; (require 'tide)

(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

(defalias 'org-babel-execute:ts 'org-babel-execute:typescript) ; FIXME

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

;; Python
(setq org-babel-default-header-args:jupyter-python '(
   (:session . "py")
   (:kernel . "python")))

(add-to-list 'exec-path "/usr/bin/sqlite3")
(add-hook 'after-init-hook 'org-roam-mode)   ; start on start-up
(setq org-roam-directory "~/org/roam")       ; set org-roam dir
(setq org-roam-tag-sources '(prop all-directories))

(setq org-roam-capture-templates
;; Default
    '(("d" "default" plain (function org-roam--capture-get-point)
        "%?"
        :file-name "%<%Y%m%d%H%M%S>-${slug}"
        :head
"#+title: ${title}
#+roam_tags:"
        :unnarrowed t)

;; Code Challange
    ("c" "Code Challange" plain (function org-roam--capture-get-point)
        "%?"
        :file-name "codeChallanges/%<%Y%m%d%H%M%S>-${slug}"
        :head
"#+title: ${title}
#+roam_tags: code-challange
:PROPERTIES:
:Source:
:Rating:
:Difficulty:
:END:

\n* Question
\n** Example
~Input: ~
~Output: ~

\n* Solution
\n* Testing
\n* Runtime Analysis
"
        :unnarrowed t)

;; Debug/Troubleshoot
("t" "Debug/Troubleshoot" plain (function org-roam--capture-get-point)
    "%?"
    :file-name "%<%Y%m%d%H%M%S>-${slug}"
    :head
"#+title: ${title}
#+roam_tags: debug fixMe

\n* Problem
\n* Solution
"
        :unnarrowed t)
))

;; TODO Note
;; TODO Code Challange

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
    '(("r" "ref" plain (function org-roam-fapture--get-point)
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
  (setq org-noter-always-create-frame nil))  ; stop opening frames

(add-hook 'org-mode-hook #'valign-mode)
(setq valign-fancy-bar 'non-nil)

;; FIXME Latex fragments in org mode
(setq org-format-latex-options
  (list
        :foreground 'default  ;;auto
        ;; :background 'auto
        :scale 3.0              ;; bigger latex fragment
        ;; :html-foreground "Black"
        ;; :html-background "Transparent"
        ;; :html-scale 1.0
        :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))

(setq lisp-indent-offset 2)

;; Pulling up the buffer menu when splitting windows
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

(setq +ivy-buffer-preview t)

(require 'doi-utils)

(setq reftex-default-bibliography '("~/org/roam/bibliography.bib"))

;; see org-ref for use of these variables
(setq org-ref-default-bibliography '("~/org-roam/bibliography.bib")
      org-ref-bibliography-notes "~/org/roam/"   ; TODO not in use
      org-ref-pdf-directory "~/org/roam/PDFs/"
      org-ref-completion-library 'org-ref-ivy-cite
      org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
      org-ref-bibliography-notes "~/org/roam"
      org-ref-notes-directory "~/org/roam"
      org-ref-notes-function 'orb-edit-notes)

(after! org
    (setq bibtex-completion-bibliography "~/org/roam/bibliography.bib"
          bibtex-completion-library-path "~/org/roam/PDFs/"
          bibtex-completion-notes-path "~/org/roam/"))
