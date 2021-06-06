;; Layout
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (toggle-debug-on-quit)
(package-initialize)

(add-to-list 'default-frame-alist '(width . 160))
(add-to-list 'default-frame-alist '(height . 50))

;; no not split
(setq split-height-threshold nil)
(setq split-width-threshold nil)
(setq ring-bell-function 'ignore)

;; Plugins
(add-to-list 'load-path "~/.emacs.d/ace-jump-mode")
(add-to-list 'load-path "~/.emacs.d/dash.el")
(add-to-list 'load-path "~/.emacs.d/emacs-neotree")
(add-to-list 'load-path "~/.emacs.d/folding.el")
(add-to-list 'load-path "~/.emacs.d/highlight-symbol.el")
(add-to-list 'load-path "~/.emacs.d/openwith")
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/powerline")
(add-to-list 'load-path "~/.emacs.d/s.el")
(add-to-list 'load-path "~/.emacs.d/xclip")
(add-to-list 'custom-theme-load-path (concat "/usr/local/share/emacs/" (emacs-version) "/etc/themes/"))


(require 'highlight-symbol)
(require 'neotree)
(require 'openwith)
(require 'powerline)
(require 'whitespace)
(require 'xclip)


;; set cua mode: ctrl+c, ctrl+v, ctrl+x, ctrl+z
;;
(cua-mode t)
(setq x-select-enable-primary t)

;; Folding
;;
;;  C-c @ C-M-s show all
;;  C-c @ C-M-h hide all
;;  C-c @ C-s show block
;;  C-c @ C-h hide block
;;  C-c @ C-c toggle hide/show
;;  M-x hs-*
;;
(load "folding" 'nomessage 'noerror)
(folding-mode-add-find-file-hook)
(defvar hs-special-modes-alist
  (mapcar 'purecopy
  '((c-mode "// {{{" "// }}}" "/[*/]" nil nil)
    (c++-mode "// {{{" "// }}}" "/[*/]" nil nil)
    (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
    (java-mode "// {{{" "// }}}" "/[*/]" nil nil)
    (js-mode "{" "}" "/[*/]" nil))))

(folding-add-to-marks-list 'c-mode  "// {{{"  "// }}}"  nil t)
(folding-add-to-marks-list 'c++-mode  "// {{{"  "// }}}"  nil t)

(add-hook 'prog-mode-hook #'hs-minor-mode) ;; auto enable


;; openwith
(openwith-mode t)
(setq openwith-associations (list
                             (list (openwith-make-extension-regexp
                                    '("pdf"
                                      ))
                                   "evince"
                                   '(file)
                             )
                             (list (openwith-make-extension-regexp
                                    '("jpg" "JPG" "png" "PNG"
                                      ))
                                   "feh -F --auto-rotate"
                                   '(file)
                             )
))


;; highlight-symbol
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)


;; whitespace settings
(setq-default indent-tabs-mode nil) ;;Use spaces instead of tabs
(setq-default tab-width 4)
;;(setq-default tab-always-indent t)
(setq c-default-style "k&r" c-basic-offset 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 4 200 4))
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; ibuffer columns
;; nearly all of this is the default layout
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 30 30 :left :elide) ; change: 30s were originally 18s
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " " filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename)))


;;
;; ace jump mode major function
;;
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)



;; powerline
(powerline-default-theme)

;; The following is set via custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(confirm-kill-processes nil)
 '(custom-enabled-themes '(tsdh-dark))
 '(global-whitespace-mode nil)
 '(package-selected-packages '(xclip))
 '(safe-local-variable-values '((secret-ftp-password . "secret")))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-follow-symlinks 'ask)
 '(xterm-mouse-mode t))

;; other settings
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq make-backup-files nil)
(global-linum-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(setq confirm-kill-processes nil)
(setq xterm-mouse-mode 1)
(setq x-select-enable-clipboard t)
(global-set-key [(control x) (k)]  'kill-this-buffer)
(global-set-key (kbd "<select>")   'move-end-of-line) ; end key
(global-set-key (kbd "ESC <up>")   'beginning-of-buffer)
(global-set-key (kbd "ESC <down>") 'end-of-buffer)
(global-set-key (kbd "C-x C-y")    'kill-whole-line)


;; multiple cursors
;;(global-unset-key (kbd "M-<down-mouse-1>"))
;;(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
;; neotree settings
(setq neo-hidden-regexp-list '("^\\." "\\.cs\\.meta$" "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.class$" "\\.o$"))
(setq neo-theme 'arrow)
(setq neo-window-fixed-size nil)
(setq neo-window-width 35)
(progn
    ;; Every time when the neotree window is opened, it will try to find current
    ;; file and jump to node.
;;    (setq-default neo-smart-open t)
    ;; Do not allow neotree to be the only open window
    (setq-default neo-dont-be-alone t)
    )


;; key bindings
(global-set-key [f4] (lambda() (interactive)
                       (setq command (concat "tmux send-keys -t 1 'cd " (neo-buffer--get-filename-current-line) "' Enter"))
                       (shell-command command)
                       )
                )
(global-set-key [f7] 'neotree-find)
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f12] (lambda() (interactive)
                        (redraw-display)
                        ))


(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)


;; ediff
(setq ediff-split-window-function 'split-window-horizontally)


;; xclip
(xclip-mode 1)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-line ((t (:background "gray20" :foreground "violet"))))
 '(whitespace-newline ((t (:foreground "darkgray" :weight normal)))))


(setq whitespace-style
  '(empty lines-tail tabs tab-mark trailing))


;; mouse scroll
(require 'mouse)
(defun scroll-up-10-lines ()
  "Scroll up 10 lines"
  (interactive)
  (scroll-up 10))

(defun scroll-down-10-lines ()
  "Scroll down 10 lines"
  (interactive)
  (scroll-down 10))

(global-set-key (kbd "<mouse-4>") 'scroll-down-10-lines) ;
(global-set-key (kbd "<mouse-5>") 'scroll-up-10-lines) ;


;; tab indent
(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 4))

(defun shift-left ()
  (interactive)
  (shift-region -4))


(global-set-key (kbd "<backtab>") 'shift-left)
(global-set-key (kbd "<tab>") 'shift-right)


;; exit emacs
(defun my-save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer, then kill this Emacs process.
With prefix ARG, silently save all file-visiting buffers without asking.
If there are active processes where `process-query-on-exit-flag'
returns non-nil and `confirm-kill-processes' is non-nil,
asks whether processes should be killed.
Runs the members of `kill-emacs-query-functions' in turn and stops
if any returns nil.  If `confirm-kill-emacs' is non-nil, calls it."
  (interactive "P")
  (save-some-buffers arg t)
  (let ((confirm confirm-kill-emacs))
    (and
     (or (not (fboundp 'process-list))
         ;; process-list is not defined on MSDOS.
         (not confirm-kill-processes)
         (let ((processes (process-list))
               active)
           (while processes
             (and (memq (process-status (car processes)) '(run stop open listen))
                  (process-query-on-exit-flag (car processes))
                  (setq active t))
             (setq processes (cdr processes)))
           (or (not active)
               (with-current-buffer-window
                (get-buffer-create "*Process List*") nil
                #'(lambda (window _value)
                    (with-selected-window window
                      (unwind-protect
                          (progn
                            (setq confirm nil)
                            (yes-or-no-p "Active processes exist; kill them and exit anyway? "))
                        (when (window-live-p window)
                          (quit-restore-window window 'kill)))))
                (list-processes t)))))
     ;; Query the user for other things, perhaps.
     (run-hook-with-args-until-failure 'kill-emacs-query-functions)
     (or (null confirm)
         (funcall confirm "Really exit Emacs? "))
     (kill-emacs))))

(fset 'save-buffers-kill-emacs 'my-save-buffers-kill-emacs)

;;(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-x\C-b" 'ibuffer)
(powerline-default-theme)


(defun dos2unix ()
      "Not exactly but it's easier to remember"
      (interactive)
      (set-buffer-file-coding-system 'unix 't) )


;; (server-start) ;; finally start the server to emacsclient
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
