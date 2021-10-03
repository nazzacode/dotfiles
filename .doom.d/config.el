;; [[file:../dotfiles/.doom.d/config.org::*Magic Incantation][Magic Incantation:1]]
;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Magic Incantation:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*User Info][User Info:1]]
(setq user-full-name "Nathan Sharp"
      my-name "nazzacode"
      user-mail-address "nasharp@outlook.com")
;; User Info:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Better Defaults][Better Defaults:1]]
(setq auto-save-default t
      make-backup-files t
      tab-width 2)

(setq-default tab-width 2)

(pixel-scroll-mode 1) ; smooth scrolling
;; Better Defaults:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*UI][UI:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Theme][Theme:1]]
;; (setq doom-theme 'my-doom-dark+)
(setq doom-theme 'my-doom-gruvbox)
;; Theme:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Fonts][Fonts:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Window Divider][Window Divider:1]]
;; (defun my-change-window-divider ()
;;   (let ((display-table (or buffer-display-table standard-display-table)))
;;     (set-display-table-slot display-table 5 ?│)
;;     (set-window-display-table (selected-window) display-table)))

;; (add-hook 'window-configuration-change-hook 'my-change-window-divider)
;; Window Divider:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Modeline][Modeline:1]]
;; TODO minibuffer modeline + centaur

;; (custom-set-faces!
;;     '(mode-line :family "Iosevka Aile")  ; :height 0.85)
;;     '(mode-line-inactive :family "Iosevka Aile"))  ; :height 0.85))

(setq doom-modeline-height 35
      doom-modeline-major-mode-icon t)
;; Modeline:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Writeroom Mode][Writeroom Mode:1]]
;; TODO increase font less
;;(setq writeroom-mode-line t)
;; Writeroom Mode:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Fix ~#+end_src~ background bleeding][Fix ~#+end_src~ background bleeding:1]]
;; HELP The following code seems to be lasting on theme change (even when commented)!
;; (custom-set-faces
;;  '(org-block-begin-line ((t (:background "#1e1e1e"))))
;;  '(org-block-end-line   ((t (:background "#1e1e1e")))))
;; (custom-theme-set-faces
;;  'gruvbox-dark
;;  '(org-block-begin-line ((t (:background "#713adf"))))
;;  '(org-block-end-line   ((t (:background "#aaaaaa")))))
;; Fix ~#+end_src~ background bleeding:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*General][General:1]]
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

;; (setq org-blank-before-new-entry
;;   '((heading . t) (plain-list-item . t)))
;; General:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Headings][Headings:1]]
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
;; Headings:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Todo's][Todo's:1]]
(setq org-todo-keywords '(
  (sequence "TODO(t)" "DOING(d)" "STRT(s)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "MAYBE(m)" "ERROR(e)" "FIXME(f)" "UPDATE(u)" "(x)" "|" "DONE(D)" "CANCL(c)" "DEPRECATED(E)")
  (sequence "[ ](T)" "[-](-)" "[?](?)" "|" "[X](X)")
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
  ("NO" . +org-todo-cancel)
))
;; Todo's:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Tags][Tags:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Tables][Tables:1]]
;; (add-hook 'org-mode-hook #'valign-mode)
;; (setq valign-fancy-bar 'non-nil)
;; Tables:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Org-roam][Org-roam:1]]
;; (add-hook 'after-init-hook 'org-roam-setup)   ; FIXME start on start-up BREAKING CONFIG ON REDOWNLOAD
(setq org-roam-directory "~/org/roam"       ; set org-roam dir
      +org-roam-open-buffer-on-find-file nil
)
;; Org-roam:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Org Roam Capture Templates][Org Roam Capture Templates:1]]
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

\n* [ ] Solution
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
#+filetags:
#+startup: show2levels

\n* Todo
\n* Done")

    :unnarrowed t)
  )
)
;; Org Roam Capture Templates:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*org-roam-ui][org-roam-ui:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Hiding the Properties Drawer][Hiding the Properties Drawer:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Org-roam-bibtex (ORB)][Org-roam-bibtex (ORB):1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Org-ref][Org-ref:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Helm-bibtex][Helm-bibtex:1]]
(after! org
    (setq bibtex-completion-bibliography "~/org/roam/PDFs/bibliography.bib"
          bibtex-completion-library-path "~/org/roam/PDFs/"
          bibtex-completion-notes-path "~/org/roam/PDFs"))
;; Helm-bibtex:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Org-Babel (src blocks)][Org-Babel (src blocks):1]]
;; typescript
(org-babel-do-load-languages
  'org-babel-load-languages
    '((typescript . t)
      (nix . t)
      (python . t)
      (dot . t)
      ;; (sh . t)
      ;; (js . t)
      (haskell . t)
      (jupyter . t)))

(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

;; (defalias 'org-babel-execute:ts 'org-babel-execute:typescript) ; FIXME
;; Org-Babel (src blocks):1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Jupyter][Jupyter:1]]
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
   (:kernel . "python")))

;; Haskell
(setq org-babel-default-header-args:jupyter-haskell '(
   (:session . "hs")
   (:kernel . "haskell")))
;; Jupyter:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Org-noter][Org-noter:1]]
(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-always-create-frame nil))  ; stop opening frames
;; Org-noter:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Hypothesis][Hypothesis:1]]
(setq hypothesis-username "nazzacode"
      hypothesis-token "6879-DJYjeV3gat2emzWKlSGkQu20tQTvQK3s7xVSepSdjfA")
;; Hypothesis:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Show Properties (Drawer)][Show Properties (Drawer):1]]
(defun org+-show-drawers ()
  "Show all property drawers in current buffer."
  (interactive)
  (let ((data (org-element-parse-buffer)))
    (org-element-map
    data
    'property-drawer
      (lambda (drawer)
    (let ((b (org-element-property :begin drawer))
          (e (org-element-property :end drawer)))
      (org-flag-region b e nil 'org-hide-drawer))))))

(put 'org+-show-drawers 'safe-local-eval-function t)
;; Show Properties (Drawer):1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*peep-dired][peep-dired:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Agenda][Agenda:1]]
;; (custom-set-variables '(org-agenda-files (list "~/org/roam/gcal.org")))
 (setq org-agenda-files '("~/org/roam/gcal.org"))
;; Agenda:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Clean category column garbage][Clean category column garbage:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Calender][Calender:1]]
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
;; Calender:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Treemacs][Treemacs:1]]
;; (after! treemacs
;;   (setq doom-themes-treemacs-enable-variable-pitch nil)) ; TODO try '
;; Treemacs:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Pdf (tools)][Pdf (tools):1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Nov.el][Nov.el:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Latex][Latex:1]]
;; FIXME Latex fragments in org mode
(setq org-format-latex-options
  (list
        :foreground 'default  ;;auto
        ;; :background 'auto
        :scale 1.7              ;; bigger latex fragment
        ;; :html-foreground "Black"
        ;; :html-background "Transparent"
        ;; :html-scale 1.0
        :matchers '("begin" "$1" "$" "$$" "\\(" "\\[")))
;; Latex:1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Direnv (Nix)][Direnv (Nix):1]]
(use-package direnv
 :config
 (direnv-mode))
;; Direnv (Nix):1 ends here

;; [[file:../dotfiles/.doom.d/config.org::*Typescript][Typescript:1]]
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

;; [[file:../dotfiles/.doom.d/config.org::*Misc][Misc:1]]
(setq lisp-indent-offset 2)
;; Misc:1 ends here
