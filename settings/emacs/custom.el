;; Define and initialise package repositories
(require 'package)

; packet an liste anhängen
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

; Auflistung zu verwendender packete !achtung alle anderen werden überschrieben 
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) 

;; Laden von Aspell
(setq ispell-program-name "aspell")
;; Verwenden von UTF-8 mit Aspell
(setq ispell-extra-args '("--encoding=utf-8"))

;; use-package to simplify the config file
(unless package-archive-contents
        (package-refresh-contents))

;; Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1) ; Disable the toolbar
(menu-bar-mode -1) ; Disable the menu bar (F10)
(scroll-bar-mode -1) ; Disable visible scrollbar
(set-fringe-mode 10) ; Give some breathing room
(defalias 'yes-or-no-p 'y-or-n-p)

;; alias
(global-set-key (kbd "C-7") 'undo)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)

;; bell
(setq visible-bell t)

;; Theme
;;(use-package exotica-theme
;;  :config (load-theme 'exotica t))

; first install: Alt+x all-the-icons-install-fonts
(use-package all-the-icons)

;;;modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
;;or
;(add-hook 'window-setup-hook #'doom-modeline-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 25)))
 ; or
;  :hook (window-setup . doom-modeline-mode))
  (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  (setq doom-modeline-icon (display-graphic-p)) ;; Aktiviert die Anzeige von Symbolen
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)

(use-package doom-themes
  :init(load-theme 'doom-nord t))

;(require 'nord-theme)
;(load-theme 'nord t)


;; show command log on the right side with info about the commands
(use-package command-log-mode)
(setq command-log-mode-auto-show t)

;; Zeilenzahl
(column-number-mode)
(global-display-line-numbers-mode)

;; Rainbow Deliminiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; which-key (help to find keys)
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy
 ; :diminish ; not show ivy mode in bottom header console
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;(use-package help-fns+
;  :ensure t)

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun rune/evil-hook()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))
  (add-to-list 'evil-emacs-state-modes mode)))
    
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package general
;(general-define-key
; "C-M-j" 'counsel-switch-buffer)
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (rune/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt"'(counsel-load-theme :which-key "choose theme")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary "german-new8")
 '(package-selected-packages
   '(evil general gerneral help-fns+ helpful ivy-rich which-key rainbow-delimiters all-the-icons doom-themes doom doom-modeline-now-playing doom-modeline counsel ivy use-package nord-theme exotica-theme command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
