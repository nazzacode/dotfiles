;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! alert)             ; notification interface
(package! all-the-icons-dired) ; file icons fordired
(package! company-box)       ; completion UI fame/box
(package! company-math)      ; latex unicode completion menu
(package! dashboard)
(package! eldoc-eval)
(package! evil-terminal-cursor-changer)
(package! good-scroll)
(package! graphviz-dot-mode) ; graph diagrams
(package! highlight-indent-guides)
(package! hypothesis :recipe (:host github :repo "Kungsgeten/hypothesis")) ; webpage highlighting and notes
(package! justify-kp :recipe (:host github :repo "Fuco1/justify-kp"))  ; nice paragraph justification for novel mode
(package! mini-modeline)     ; modeline embedded in minibuffer
(package! mixed-pitch)
(package! nov)               ; epub reader
(package! ob-typescript)
(package! org-appear)        ; show emphasis markers when inside fragment
(package! org-bars :recipe (:host github :repo "tonyaldon/org-bars"))
(package! org-contrib)       ; extra utilities such as the :ignore: tag
(package! org-download)      ; screenshots
(package! org-fragtog)       ; auto latex fragement rendering
(package! org-modern)        ; wowoa cool ui for org
(package! org-noter)         ; pdf + synced notes; side by side
(package! org-ref)           ; academic referencing in org mode
(package! org-roam-bibtex)   ; org + roam + bibtex
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out"))) ; graph explorer for org roam
(package! org-special-block-extras)
(package! org-superstar)     ; fancy headings and bullets
(package! pdf-continuous-scroll-mode :disable (not (and (fboundp 'init-image-library) (init-image-library 'svg))))
(package! pdf-continuous-scroll-mode :recipe (:host github :repo "dalanicolai/pdf-continuous-scroll-mode.el"))
(package! pdf-view-restore)
(package! peep-dired)        ; preview popup for dired
(package! persist)           ; variables that persist across sessions
(package! rainbow-mode)      ; sets background color for color names
(package! request)           ; elisp http
(package! transpose-frame)   ; allows transposing the frame among other operations
(package! tree-sitter)       ; better syntax highlighting
(package! tree-sitter-langs)
(package! treemacs-icons-dired)  ; treemacs icons
(package! ts-comint)         ; typescript REPL
(package! valign)            ; pretty tables
(package! visual-fill-column)
(package! websocket)
(package! winum)             ; numbers windows in some way?
(package! yascroll)          ; ascii scrollbar
;; (package! deft)              ; search buffer
;; (package! direnv)            ; dev environments per filepath
;; (package! doom-modeline)
;; (package! oc-biblatex)
;; (package! pdf-tools  :recipe (:host github :repo "dalanicolai/pdf-tools" :branch "continuous-scroll-version-3" :files ("lisp/*.el" "README" "vimura-server/*.py" ("build" "Makefile") ("build" "server") (:exclude "lisp/tablist.el" "lisp/tablist-filter.el"))))
;; (package! phscroll :recipe (:host github :repo "misohena/phscroll"))  ; partial horizontal scrolling in org mode (use case: wide tables)
;; (package! webkit :recipe (:host github :repo "akirakyle/emacs-webkit"  ; browser and ting :files (:defaults "*.js" "*.css" "*.so") :pare-build ("make")))

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
