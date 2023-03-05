;;; my-doom-dark+-theme.el --- inspired by dark+ Theme by equinusocio -*- lexical-binding: t; no-byte-compile: t; -*-

(require 'doom-themes)

(defgroup doom-dark+-theme nil
  "Options for the `doom-dark' theme."
  :group 'doom-themes)

;; (defcustom doom-dark+-padded-modeline doom-themespadded-modeline
(defcustom doom-dark+-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-dark+-theme
  :type '(choice integer boolean))

(defcustom doom-dark+-blue-modeline nil
  "If non-nil, mode-line's color will be blue instead of the default purple."
  :group 'doom-dark+-theme
  :type '(choice integer boolean))

;;
(def-doom-theme my-doom-dark+
  "A dark theme inspired by dark+ Theme by equinusocio"

  ;; name        default   256       16
  ;; ((bg         '("#1C1C1C" "#1C1C1C" nil)) ; old
  ;;  (bg-alt     '("#2B2B2B" "#2B2B2B" nil)) ; old
   ;; (bg-alt     '("#303030" "#303030"  nil))
  ((bg         '("#242424" "#242424" nil))
   (bg-alt     '("#292929" "#292929" nil))
   (base0      '("#111111" "#111111"   "black"))
   (base1      '("#1d1d1d" "#1C1C1C" "brightblack"))
   (base2      '("#181818" "#181818" "brightblack")) ;; src_block_backgroud
   (base3      '("#3a3a3a" "#3a3a3a" "brightblack"))
   (base4      '("#4b474c" "#444444" "brightblack"))
   (base5      '("#6a6a6a" "#585858" "brightblack"))
   (base6      '("#237AD3" "#2277DD" "brightblack"))
   (base7      '("#777778" "#767676" "brightblack"))
   (base8      '("#f4f4f4" "#a8a8a8" "white"))
   (fg         '("#c2c2c2" "#e4e4e4" "brightwhite"))
   (fg-alt     '("#AEAFAD" "#bcbcbc" "white"))

   (grey base7)
   (red          '("#D16969" "#DD6666" "red"))
   (orange       '("#DB8E73" "#DD8877" "brightred"))
   (green        '("#579C4C" "#559944" "green"))
   (light-green  '("#B5CEA8" "#BBCCAA" "green"))
   (teal         '("#35CDAF" "#33CCAA" "brightgreen"))
   (yellow       '("#D7BA7D" "#DDBB77" "brightyellow"))
   (light-yellow '("#D9DAA2" "#DDDDAA" "brightyellow"))
   (blue         '("#339CDB" "#3399DD" "brightblue"))
   (dark-blue    '("#124F7B" "#114477" "blue"))
   (magenta      '("#C586C0" "#CC88CC" "brightmagenta"))
   (violet       '("#BB80B3" "#BB88BB" "magenta"))
   (dark-violet  '("#68217A" "#662277" "magenta"))
   (cyan         '("#85DDFF" "#5FD7FF" "brightcyan"))
   (dark-cyan    '("#207FA1" "#2277AA" "cyan"))

   ;; face categories -- required for all themes
   (highlight      fg) ; base6)
   (vertical-bar   (doom-lighten bg-alt 0.15)) ; window divider
   (selection      base4)
   (builtin        magenta)
   (comments       base7)
   (doc-comments   base7)
   (constants      blue)
   (functions      light-yellow)
   (keywords       blue)
   (methods        light-yellow)
   (operators      cyan)
   (type           teal)
   (strings        orange)
   (variables      cyan)
   (numbers        light-green)
   (region         (doom-darken base6 0.5))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    blue)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (modeline-bg     (doom-darken bg 0.1)) ;; HACK PRIME OFFENDER WHEN IN PURPLE!
   (modeline-bg-alt (doom-darken bg 0.1))
   (modeline-fg     (doom-darken fg 0.4))
   (modeline-fg-alt (doom-darken fg 0.6))

   (-modeline-pad
    (when doom-dark+-padded-modeline
      (if (integerp doom-dark+-padded-modeline) doom-dark+-padded-modeline 0)))) ;; 4

  ;;;; Base theme face overrides
  ((lazy-highlight :background base4 :foreground fg :distant-foreground fg :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (mode-line-emphasis
    :foreground modeline-fg
    :weight 'normal)
   (fringe :background bg)

   ;;;; all-the-icons
   (all-the-icons-dblue :foreground blue)
   ;;;; centaur-tabs
   (centaur-tabs-active-bar-face :background base6)
   (centaur-tabs-selected-modified
    :inherit 'centaur-tabs-selected :foreground fg :weight 'bold)
   (centaur-tabs-unselected-modified
    :inherit 'centaur-tabs-unselected :foreground fg :weight 'bold)
   (centaur-tabs-modified-marker-selected
    :inherit 'centaur-tabs-selected :foreground fg)
   (centaur-tabs-modified-marker-unselected
    :inherit 'centaur-tabs-unselected :foreground fg)
   ;;;; company
   (company-tooltip-selection     :background region)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;\;;; dashboard
   (dashboard-heading :foreground green :weight 'semi-bold)
   ;;;; dired-k
   (dired-k-commited :foreground base4)
   (dired-k-modified :foreground vc-modified)
   (dired-k-ignored :foreground cyan)
   (dired-k-added    :foreground vc-added)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-dark+-blue-modeline base6 dark-violet))
   (doom-modeline-buffer-file :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-major-mode :inherit 'doom-modeline-buffer-path)
   (doom-modeline-buffer-modified :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-debug :inherit 'mode-line-emphasis)
   (doom-modeline-evil-insert-state :foreground cyan)
   (doom-modeline-evil-visual-state :foreground yellow)
   (doom-modeline-info :inherit 'mode-line-emphasis)
   (doom-modeline-lsp-success :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-persp-name :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-project-dir :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-project-parent-dir :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-urgent :inherit 'mode-line-emphasis)
   (doom-modeline-warning :inherit 'mode-line-emphasis)
   ;;;; ivy
   (counsel-active-mode :foreground (doom-lighten base6 0.1))
   (ivy-minibuffer-match-face-2 :foreground (doom-lighten base6 0.1) :weight 'extra-bold)
   ;;;; js2-mode
   (js2-jsdoc-tag              :foreground magenta)
   (js2-object-property        :foreground cyan)
   (js2-object-property-access :foreground cyan)
   (js2-function-param         :foreground violet)
   (js2-jsdoc-type             :foreground base8)
   (js2-jsdoc-value            :foreground cyan)
   ;;;; lsp-mode
   (lsp-lens-face              :foreground base7 :height 0.8)
   ;;;; man <built-in>
   (Man-overstrike :inherit 'bold :foreground magenta)
   (Man-underline :inherit 'underline :foreground blue)
   ;; outline  (headings)
   ;;;; outline <built-in>
   ;; ((outline-1 &override) :foreground (doom-darken base8 0.2))
   ;; ((outline-2 &override) :foreground (doom-lighten cyan 0.55))
   ;; ((outline-3 &override) :foreground (doom-lighten violet 0.55))
   ;; ((outline-4 &override) :foreground (doom-lighten yellow 0.55))
   ;; ((outline-5 &override) :foreground (doom-lighten green 0.55))
   ;; ((outline-6 &override) :foreground (doom-lighten orange 0.55))
   ;; ((outline-7 &override) :foreground (doom-lighten teal 0.55))
   ;; ((outline-8 &override) :foreground (doom-lighten red 0.5))

   ((outline-1 &override) :foreground (doom-darken fg 0.2))
   ((outline-2 &override) :foreground (doom-darken fg 0.2))
   ((outline-3 &override) :foreground (doom-darken fg 0.2))
   ((outline-4 &override) :foreground (doom-darken fg 0.2))
   ((outline-5 &override) :foreground (doom-darken fg 0.2))
   ((outline-6 &override) :foreground (doom-darken fg 0.2))
   ((outline-7 &override) :foreground (doom-darken fg 0.2))
   ((outline-8 &override) :foreground (doom-darken fg 0.2))
   ;;
   ;;;; org <built-in>
   ;; ((org-block &override) :background (doom-darken bg-alt 0.1))
   ((org-block &override) :background bg)
   ;; org src blocks
   ;; ((org-block-background &override)  bg)
   ((org-block-begin-line &override) :background (doom-lighten bg-alt 0.02)) ;bg)
   ((org-block-end-line &override) :background (doom-lighten bg-alt 0.02)) ; bg)
   ;;;; org-pomodoro
   (org-pomodoro-mode-line :inherit 'mode-line-emphasis) ; unreadable otherwise
   (org-pomodoro-mode-line-overtime :inherit 'org-pomodoro-mode-line)
   (org-pomodoro-mode-line-break :inherit 'org-pomodoro-mode-line)
   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground magenta)
   (rainbow-delimiters-depth-2-face :foreground orange)
   (rainbow-delimiters-depth-3-face :foreground green)
   (rainbow-delimiters-depth-4-face :foreground cyan)
   (rainbow-delimiters-depth-5-face :foreground violet)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground blue)
   (rainbow-delimiters-depth-8-face :foreground teal)
   (rainbow-delimiters-depth-9-face :foreground dark-cyan)
   ;;;; rjsx-mode
   (rjsx-tag :foreground blue)
   (rjsx-attr :foreground cyan :slant 'italic :weight 'medium)
   ;;;; tooltip
   (tooltip :background base2 :foreground fg)
   ;;; yascroll
   ;;;; treemacs
   (treemacs-root-face :foreground fg :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-root-face :foreground fg :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground fg)
   (treemacs-directory-face :foreground fg)
   (treemacs-git-modified-face :foreground blue)))

;;; doom-dark+-theme.el ends here
