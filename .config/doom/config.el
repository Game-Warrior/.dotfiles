;;    _____ __          __
;;  / ____| \ \        / / GameWarrior
;; | |  __   \ \  /\  / /  https://github.com/game-warrior
;; | | |_ |   \ \/  \/ /   @gamewarrior010@social.linux.pizza
;; | |__| |    \  /\  /    https://www.gnu.org/software/emacs/
;;  \_____|     \/  \/     https://:github.com/doomemacs/doomemacs

(beacon-mode 1)

(setq chatgpt-shell-openai-key "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")

(setq dall-e-shell-openai-key "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")

(setq user-full-name "Gardner Berry"
    user-mail-address "gardner@gamewarrior.xyz")

(setq frame-title-format "Hey bro, just FYI, this buffer is called %b or something like that.")

(setq doom-theme 'doom-oceanic-next)
(map! :leader
      :desc "Load new theme" "h t" #'load-theme)

(setq browse-url-browser-function 'browse-url-default-browser)

(menu-bar-mode -1)
;; (define-key global-map [menu-bar options] nil)
;; (define-key global-map [menu-bar file] nil)
;; (define-key global-map [menu-bar File] nil)
;; (define-key global-map [menu-bar edit] nil)
;; (define-key global-map [menu-bar tools] nil)
;; (define-key global-map [menu-bar buffer] nil)
;; (define-key global-map [menu-bar help-menu] nil)

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-create-empty-file
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "Preview")
                              ("jpg" . "Preview")
                              ("png" . "Preview")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(assoc-delete-all "Open project" +doom-dashboard-menu-sections)
(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)

(cond ((eq system-type 'darwin)
       (add-hook! '+doom-dashboard-functions :append
         (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Powered by the 🍎 walled garden!"))))
      ((eq system-type 'gnu/linux)
        (add-hook! '+doom-dashboard-functions :append
         (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Powered bye 🐂 Oxen and 🐧 Penguins!"))))
      ((eq system-type 'windows-nt)
       (add-hook! '+doom-dashboard-functions :append
         (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Powered by Proprietary Garbage!")))))

(defun gw/doom-art ()
  (let* ((banner'("______ _____ ____ ___ ___"
                  "`  _  V  _  V  _ \\|  V  ´"
                  "| | | | | | | | | |     |"
                  "| | | | | | | | | | . . |"
                  "| |/ / \\ \\| | |/ /\\ |V| |"
                  "|   /   \\__/ \\__/  \\| | |"
                  "|  /                ' | |"
                  "| /     E M A C S     \\ |"
                  "´´                     ``"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'gw/doom-art)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(add-hook 'elfeed-show-mode-hook 'visual-line-mode)
(evil-define-key 'normal elfeed-show-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev)
(evil-define-key 'normal elfeed-search-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev)

(setq elfeed-feeds (quote
                     (
                     ;; General
                     ("https://frame.work/blog.rss" Framework)
                     ;; Linux
                     ("https://blog.linuxmint.com/?feed=rss2" linux LinuxMint)
                     ("https://archlinux.org/news/" linux Arch)
                     ("https://fedoramagazine.org/feed/" linux Fedora)
                     ("https://endeavouros.com/news/" linux EndeavourOS)
                     ;; Boat Stuff
                     ("https://buffalonickelblog.com/feed/" Buffalo-Nickle boat)
                     ("https://mobius.world/feed/" Mobius boat)
                     ;; Emacs
                     ("http://xenodium.com/rss.xml" emacs Xenodium)
                     ("https://cmdln.org/post/" emacs Commandline)
                     ("https://karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-and-content.xml" Karal-Voit emacs)
                     )))

(setq doom-font (font-spec :family "Ubuntu Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "Ubuntu Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t))

;; for sending mails
(require 'smtpmail)

;; we installed this with homebrew
(setq mu4e-mu-binary (executable-find "mu"))

;; this is the directory we created before:
(setq mu4e-maildir "~/.maildir")

;; this command is called to sync imap servers:
(setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))

;; how often to call it in seconds:
(setq mu4e-update-interval 300)

;; save attachment to desktop by default
;; or another choice of yours:
(setq mu4e-attachment-dir "~/Desktop")

;; rename files when moving - needed for mbsync:
(setq mu4e-change-filenames-when-moving t)

;; list of your email adresses:
(setq mu4e-user-mail-address-list '("berrygw06@gmail.com"))

;; gpg encryptiom & decryption:

;; this can be left alone

(require 'epa-file)

(epa-file-enable)

(setq epa-pinentry-mode 'loopback)

(auth-source-forget-all-cached)

;; don't keep message compose buffers around after sending:
(setq message-kill-buffer-on-exit t)

;; send function:
(setq send-mail-function 'sendmail-send-it
      message-send-mail-function 'sendmail-send-it)

;; send program:
;; this is exeranal. remember we installed it before.
(setq sendmail-program (executable-find "msmtp"))

;; select the right sender email from the context.
(setq message-sendmail-envelope-from 'header)

;; chose from account before sending
;; this is a custom function that works for me.
;; well I stole it somewhere long ago.
;; I suggest using it to make matters easy
;; of course adjust the email adresses and account descriptions
(defun timu/set-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
        (let*
            ((from (save-restriction
                     (message-narrow-to-headers)
                     (message-fetch-field "from")))
             (account
              (cond
               ((string-match "berrygw06@gmail.com" from) "personal"))))
          (setq message-sendmail-extra-arguments (list '"-a" account))))))

(add-hook 'message-send-mail-hook 'timu/set-msmtp-account)

;; mu4e cc & bcc
;; this is custom as well
(add-hook 'mu4e-compose-mode-hook
          (defun timu/add-cc-and-bcc ()
            "My Function to automatically add Cc & Bcc: headers.
    This is in the mu4e compose mode."
            (save-excursion (message-add-header "Cc:\n"))
            (save-excursion (message-add-header "Bcc:\n"))))

;; mu4e address completion
(add-hook 'mu4e-compose-mode-hook 'company-mode)

;; store link to message if in header view, not to header query:
(setq org-mu4e-link-query-in-headers-mode nil)

;; don't have to confirm when quitting:
(setq mu4e-confirm-quit nil)

;; number of visible headers in horizontal split view:
(setq mu4e-headers-visible-lines 20)

;; don't show threading by default:
(setq mu4e-headers-show-threads nil)

;; hide annoying "mu4e Retrieving mail..." msg in mini buffer:
(setq mu4e-hide-index-messages t)

;; customize the reply-quote-string:
(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M :\n")

;; M-x find-function RET message-citation-line-format for docs:
(setq message-citation-line-function 'message-insert-formatted-citation-line)

;; by default do not show related emails:
(setq mu4e-headers-include-related nil)

;; by default do not show threads:
(setq mu4e-headers-show-threads nil)

(defun gw/insert-todays-date (prefix)
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%m-%d-%Y")
                 ((equal prefix '(16)) "%Y-%m-%d"))))
    (insert (format-time-string format))))

(require 'calendar)
(defun gw/insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(map! :leader
      (:prefix ("i d" . "Insert date")
        :desc "Insert any date" "a" #'gw/insert-any-date
        :desc "Insert todays date" "t" #'gw/insert-todays-date))

(setq display-line-numbers-type nil)
(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

(set-face-attribute 'mode-line nil :font "Ubuntu Mono-18")
(setq doom-modeline-height 25     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-major-mode-icon t  ;; Whether display the icon for `major-mode'. It respects `doom-modeline-icon'.      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t ;; adds folder icon next to persp name
      doom-modeline-time t ;; Shows the time
      doom-modeline-enable-word-count '(markdown-mode gfm-mode org-mode fountain-mode) ;; Show word count
      doom-modeline-lsp t ;; Show LSP status
      )

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/Documents/"
        org-agenda-files '("~/Documents/agenda.org" "~/Documents/To-Research.org" "~/Documents/inbox.org" "~/Documents/notes.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        ;; org-ellipsis " ▼ "
        org-ellipsis " ↴ "
        ;; org-ellipsis" ⤷ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "✿" "✸" "◆" "○")
        org-superstar-item-bullet-alist '((?- . ?➤) (?+ . ?✦)) ; changes +/- symbols in item lists
        ;; org-list-demote-modify-bullet '(("+" . "*") ("*" . "-") ("-" . "+"))
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" ))) ; Task has been cancelled
  (org-superstar-mode 1))

(after! org
(defun gw/org-colors-doom-one ()
  "Enable Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#51afef" ultra-bold)
         (org-level-2 1.6 "#c678dd" extra-bold)
         (org-level-3 1.5 "#98be65" bold)
         (org-level-4 1.4 "#da8548" semi-bold)
         (org-level-5 1.3 "#5699af" normal)
         (org-level-6 1.2 "#a9a1e1" normal)
         (org-level-7 1.1 "#46d9ff" normal)
         (org-level-8 1.0 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-gruvbox-dark ()
  "Enable Gruvbox Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#fb4934" ultra-bold)
         (org-level-2 1.6 "#fe8019" extra-bold)
         (org-level-3 1.5 "#8ec07c" bold)
         (org-level-4 1.4 "#98971a" semi-bold)
         (org-level-5 1.3 "#83a598" normal)
         (org-level-6 1.2 "#458588" normal)
         (org-level-7 1.1 "#d3869b" normal)
         (org-level-8 1.0 "#b16286" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-monokai-pro ()
  "Enable Monokai Pro colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#ff6188" ultra-bold)
         (org-level-2 1.6 "#fc9867" extra-bold)
         (org-level-3 1.5 "#ffd866" bold)
         (org-level-4 1.4 "#A9DC76" semi-bold)
         (org-level-5 1.3 "#78DCE8" normal)
         (org-level-6 1.2 "#81A2BE" normal)
         (org-level-7 1.1 "#AB9DF2" normal)
         (org-level-8 1.0 "#CC6666" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-nord ()
  "Enable Nord colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#81a1c1" ultra-bold)
         (org-level-2 1.6 "#b48ead" extra-bold)
         (org-level-3 1.5 "#a3be8c" bold)
         (org-level-4 1.4 "#ebcb8b" semi-bold)
         (org-level-5 1.3 "#bf616a" normal)
         (org-level-6 1.2 "#88c0d0" normal)
         (org-level-7 1.1 "#81a1c1" normal)
         (org-level-8 1.0 "#b48ead" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-oceanic-next ()
  "Enable Oceanic Next colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#EC5f67" ultra-bold)
         (org-level-2 1.6 "#F99157" extra-bold)
         (org-level-3 1.5 "#fac863" bold)
         (org-level-4 1.4 "#99C794" semi-bold)
         (org-level-5 1.3 "#5fb3b3" normal)
         (org-level-6 1.2 "#ec5f67" normal)
         (org-level-7 1.1 "#6699cc" normal)
         (org-level-8 1.0 "#c594c5" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-palenight ()
  "Enable Palenight colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#82aaff" ultra-bold)
         (org-level-2 1.6 "#c792ea" extra-bold)
         (org-level-3 1.5 "#c3e88d" bold)
         (org-level-4 1.4 "#ffcb6b" semi-bold)
         (org-level-5 1.3 "#a3f7ff" normal)
         (org-level-6 1.2 "#e1acff" normal)
         (org-level-7 1.1 "#f07178" normal)
         (org-level-8 1.0 "#ddffa7" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-solarized-dark ()
  "Enable Solarized Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#dc322f" ultra-bold)
         (org-level-2 1.6 "#859900" extra-bold)
         (org-level-3 1.5 "#cb4b16" bold)
         (org-level-4 1.4 "#b58900" semi-bold)
         (org-level-5 1.3 "#35a69c" normal)
         (org-level-6 1.2 "#268bd2;" normal)
         (org-level-7 1.1 "#3F88AD" normal)
         (org-level-8 1.0 "#6c71c4" normal)))

    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-solarized-light ()
  "Enable Solarized Light colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#dc322f" ultra-bold)
         (org-level-2 1.6 "#b58900" extra-bold)
         (org-level-3 1.5 "#cb4b16" bold)
         (org-level-4 1.4 "#2aa198" semi-bold)
         (org-level-5 1.3 "#268bd2" normal)
         (org-level-6 1.2 "#6c71c4" normal)
         (org-level-7 1.1 "#657b83" normal)
         (org-level-8 1.0 "#859900" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-tomorrow-night ()
  "Enable Tomorrow Night colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#81a2be" ultra-bold)
         (org-level-2 1.6 "#b294bb" extra-bold)
         (org-level-3 1.5 "#b5bd68" bold)
         (org-level-4 1.4 "#e6c547" semi-bold)
         (org-level-5 1.3 "#cc6666" normal)
         (org-level-6 1.2 "#70c0ba" normal)
         (org-level-7 1.1 "#b77ee0" normal)
         (org-level-8 1.0 "#9ec400" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun gw/org-colors-henna ()
  "Enable Henna colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#e74c3c" ultra-bold)
         (org-level-2 1.6 "#56b5c2" extra-bold)
         (org-level-3 1.5 "#53df83" bold)
         (org-level-4 1.4 "#1abc9c" semi-bold)
         (org-level-5 1.3 "#ECBE7B" normal)
         (org-level-6 1.2 "#C5A3FF" normal)
         (org-level-7 1.1 "#FFB8D1" normal)
         (org-level-8 1.0 "" normal)))))

(defun gw/org-colors-doom-one-alt ()
  "Enable an alternitive set of Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#ff6c6b" ultra-bold)
         (org-level-2 1.6 "#da8548" extra-bold)
         (org-level-3 1.5 "#ECBE7B" bold)
         (org-level-4 1.4 "#98be65" semi-bold)
         (org-level-5 1.3 "#51afef" normal)
         (org-level-6 1.2 "#2257A0" normal)
         (org-level-7 1.1 "#c678dd" normal)
         (org-level-8 1.0 "#a9a1e1" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bbc2cf"))

(defun gw/org-colors-old-hope ()
  "Enable Doom Old Hope colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#ea3d54" ultra-bold)
         (org-level-2 1.6 "#ee7b29" extra-bold)
         (org-level-3 1.5 "#78bd65" bold)
         (org-level-4 1.4 "#4fb3d8" semi-bold)
         (org-level-5 1.3 "#fedd38" normal)
         (org-level-6 1.2 "#ee7b29" normal)
         (org-level-7 1.1 "#78bd65" normal)
         (org-level-8 1.0 "#b978ab" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#cbccd1")
    (when (eq (car-safe custom-enabled-themes) 'doom-old-hope)
    (gw/org-colors-old-hope)))

(defun gw/org-colors-peacock ()
  "Enable Doom Peacock colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#ff5d38" ultra-bold)
         (org-level-2 1.6 "#26a6a6" extra-bold)
         (org-level-3 1.5 "#cb4b16" bold)
         (org-level-4 1.4 "#98be65" semi-bold)
         (org-level-5 1.3 "#4fb3d8" normal)
         (org-level-6 1.2 "#2257A0" normal)
         (org-level-7 1.1 "#c678dd" normal)
         (org-level-8 1.0 "#a9a1e1" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#cbccd1"))

(defun gw/org-colors-1337 ()
  "Enable Doom 1337 colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#FF5E5E" ultra-bold)
         (org-level-2 1.6 "#FC9354" extra-bold)
         (org-level-3 1.5 "#E9FDAC" bold)
         (org-level-4 1.4 "#B5CEA8" semi-bold)
         (org-level-5 1.3 "#468800" normal)
         (org-level-6 1.2 "#35CDAF" normal)
         (org-level-7 1.1 "#8CDAFF" normal)
         (org-level-8 1.0 "#C586C0" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#cbccd1"))

(defun gw/org-colors-oksolar-dark ()
  "Enable OKSolar Dark Colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#F23749" ultra-bold)
         (org-level-2 1.6 "#819500" extra-bold)
         (org-level-3 1.5 "#D56500" bold)
         (org-level-4 1.4 "#AC8300" semi-bold)
         (org-level-5 1.3 "#35A69C" normal)
         (org-level-6 1.2 "#2B90D8" normal)
         (org-level-7 1.1 "#3F88AD" normal)
         (org-level-8 1.0 "#DD459D" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#BBBBBB"))

(defun gw/org-colors-spacegrey ()
  "Enable Spacegrey Colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#BF616A" ultra-bold)
         (org-level-2 1.6 "#D08770" extra-bold)
         (org-level-3 1.5 "#ECBE7B" bold)
         (org-level-4 1.4 "#A3BE8C" semi-bold)
         (org-level-5 1.3 "#4db5bd" normal)
         (org-level-6 1.2 "#2B90D8" normal)
         (org-level-7 1.1 "#2257A0" normal)
         (org-level-8 1.0 "#c678dd" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#cbccd1"))

(defun gw/org-colors-ayu-mirrage ()
  "Enable Spacegrey Colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#ff3333" ultra-bold)
         (org-level-2 1.6 "#ffa759" extra-bold)
         (org-level-3 1.5 "#ffd580" bold)
         (org-level-4 1.4 "#bae67e" semi-bold)
         (org-level-5 1.3 "#95e6cb" normal)
         (org-level-6 1.2 "#5ccfe6" normal)
         (org-level-7 1.1 "#73d0ff" normal)
         (org-level-8 1.0 "#d4bfff" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#cbccc6"))

;; Load our desired gw/org-colors-* theme on startup
    (gw/org-colors-oceanic-next))
;; )

(setq org-archive-default-command 'org-archive-subtree)

(map! :leader
      (:desc "Archive Org-Todos" "v" org-archive-default-command))

(after! org
  (setq org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
      org-deadline-warning-days 0
      org-agenda-span 7
      org-agenda-start-day "-0d"
      org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)
      org-log-done 'time
      )
)

(after! org-capture
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "~/Documents/agenda.org" "%^{Headline}")
           "* TODO %?\n  %i\n  %a")
          ("T" "todo today" entry (file+headline "~/Documents/agenda.org" "%^{Headline}")
           "* TODO %?\n  %i\nDEADLINE: %t\n  %a")
          ("i" "inbox" entry (file "~/Documents/inbox.org")
           "* %?")
          ("v" "clip to inbox" entry (file "~/Documents/inbox.org")
           "* %x%?")
          ("c" "call someone" entry (file "~/Documents/inbox.org")
           "* TODO Call %?\n %U")
          ("p" "phone call" entry (file "~/Documents/inbox.org")
           "* Call from %^{Caller name}\n %U\n %i\n")
          )))

(use-package! ox-twbs)
(use-package! ox-pandoc)
(use-package! ox-gfm)
(use-package! ox-re-reveal)
(use-package! ox-epub)
;; Make it so that org-export wont use numbered headings
(setq org-export-with-section-numbers nil)

;; Reveal.js + Org mode
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
      org-reveal-title-slide "<h1>%t</h1><h2>%a</h2><h5>@Gamewarrior010@social.linux.pizza</h5>"
      org-re-reveal-title-slide "<h1>%t</h1><h2>%a</h2><h5>@Gamewarrior010@social.linux.pizza</h5>"
      org-reveal-theme "moon"
      org-re-reveal-theme "moon"
      ;; org-re-reveal-theme "blood"
      org-re-reveal-transition "slide"
      org-reveal-plugins '(markdown notes math search zoom))

(defun set-ignored-headlines-tags (backend)
     "Remove all headlines with tag ignore_heading in the current buffer.
        BACKEND is the export back-end being used, as a symbol."
     (cond ((org-export-derived-backend-p backend 'md) (setq  org-export-exclude-tags '("noexport" "mdignore")))
           ((org-export-derived-backend-p backend 'reveal) (setq  org-export-exclude-tags '("noexport" "revealignore")))
           (t (setq  org-export-exclude-tags '("noexport")))
       ))

(setq org-journal-dir "~/Documents/Personal/Journal/"
      org-journal-date-prefix "* "
      org-journal-time-prefix "** "
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org")

(setq org-publish-use-timestamps-flag nil)
(setq org-export-with-broken-links t)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(use-package org-roam
:ensure t
:init
(setq org-roam-v2-ack t)
:custom
(org-roam-directory "~/Notes")
(org-roam-completion-everywhere t)
:bind (("C-c n l" . org-roam-buffer-toggle)
       ("C-c n f" . org-roam-node-find)
       ("C-c n i" . org-roam-node-insert)
       :map org-mode-map
       ("C-M-i" . completion-at-point))
:config
(org-roam-setup))

(use-package hide-mode-line)

(defun gw/presentation-setup ()
  (interactive)
  ;; Hide the mode line
  (hide-mode-line-mode 1)

  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images

  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1))

  ;; This option is more advanced, allows you to scale other faces too
  ;; (setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
  ;;                                    (org-verbatim (:height 1.75) org-verbatim)
  ;;                                    (org-block (:height 1.25) org-block))))

(defun gw/presentation-end ()
  (interactive)
  ;; Show the mode line again
  (hide-mode-line-mode 0)

  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  ;; (text-scale-mode 0))

  ;; If you use face-remapping-alist, this clears the scaling:
  (setq-local face-remapping-alist '((default variable-pitch default))))

(use-package org-tree-slide
  :hook ((org-tree-slide-play . gw/presentation-setup)
         (org-tree-slide-stop . gw/presentation-end))
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " > ")
  (org-image-actual-width nil))

(setq global-hl-todo-mode 1)

(defun gw/todo-hl-oksolar-dark ()
  "Set TODO Colors to the OKSOLAR colors"
  (interactive)
 (setq hl-todo-keyword-faces
       '(("TODO"   . "#35A69C")
         ("FIXME"  . "#F23749")
         ("WAIT"   . "#7D80D1"))))
(defun gw/todo-hl-henna ()
  (interactive)
  (setq hl-todo-keyword-faces
        '(("TODO"  . "#1abc9c")
          ("FIXME" . "#e74c3c")
          ("WAIT"  . "#C5A3FF"))))

(gw/todo-hl-oksolar-dark)

(defun gw/writing ()
  "Toggle between writing environment modes."
  (interactive)
  (if olivetti-mode
      (progn
        (olivetti-mode -1)
        (doom-big-font-mode -1))
    (progn
      (olivetti-mode)
      (doom-big-font-mode))))

;; (map!
 ;; :meta
 ;; (:desc "Cycle through the different bullets" "TAB" #'org-cycle-list-bullets))

(load "~/.config/doom/org-novelist.el")
    ;; (org-novelist-language-tag "en-US")  ; The interface language for Org Novelist to use. It defaults to 'en-GB' when not set
    ;; (org-novelist-author "Gardner Berry")  ; The default author name to use when exporting a story. Each story can also override this setting
    ;; (org-novelist-author-email "mail@johnurquhartferguson.info")  ; The default author contact email to use when exporting a story. Each story can also override this setting
    ;; (org-novelist-automatic-referencing-p nil)  ; Set this variable to 't' if you want Org Novelist to always keep note links up to date. This may slow down some systems when operating on complex stories. It defaults to 'nil' when not set

(setq ispell-program-name "aspell")

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )

(global-set-key (kbd "M-b") 'ace-window)

(setq yas-snippet-dirs '("~/Documents/emacs-stuff/snippets"))
(yas-global-mode 1)

(add-hook 'text-mode-hook 'palimpsest-mode)

;; (map!
       ;; :leader
      ;; (:desc "Palimpsest-Send-Bottom" "n g" palimpsest-send-bottom))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; (require 'mastodon-alt)
;; (mastodon-alt-tl-activate)
(setq mastodon-instance-url "https://social.linux.pizza"
      mastodon-active-user "Gamewarrior010")

;; Enable abbreviation mode
(add-hook 'text-mode-hook 'abbrev-mode)

(require 'go-translate)

(setq gts-translate-list '(("en" "zh")))

;; (setq gts-default-translator (gts-translator :engines (gts-bing-engine)))

(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-bing-engine) (gts-google-engine))
       :render (gts-buffer-render)))

(setq display-time-day-and-date t)

(map! :after ibuffer
      :map ibuffer-mode-map
      :n "l" #'ibuffer-visit-buffer
      :n "h" #'kill-current-buffer)

(setq olivetti-style 'fringes-and-margins)

(setq +zen-text-scale 0.8)

(map! :leader
      (:desc "Open Magit" "g m" #'magit))

(add-hook 'text-mode-hook 'writegood-mode)

(setq gw/weasel-words
      '("actually"
        "basically"
        "easily"
        "easy"
        "simple"
        "simply"))
;; (setq writegood-weasel-words
      ;; (-concat writegood-weasel-words gw/weasel-words))
;; (map!
        ;; :leader
        ;; (:desc ""))

(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t))))
  ;; :config
  ;; (global-blamer-mode 1))

(setq nov-unzip-program (executable-find "bsdtar")
      nov-unzip-args '("-xC" directory "-f" filename))
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(map!
 :leader
 (:desc "Open Xwidgets URL" "y" #'xwidget-webkit-browse-url))



(setq eshell-aliases-file "~/.config/doom/eshell/aliases")

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

(map!
 :leader
 (:desc "List Synonyms for word at point" "t n" #'synosaurus-choose-and-insert))
