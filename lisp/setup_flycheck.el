;; ================================flycheck==================================
(require 'helm-flycheck)
;; 取消自动开启
;; (add-hook 'after-init-hook #'global-flycheck-mode)
(setq global-flycheck-mode nil)
;; Change the prefix.
(define-key flycheck-mode-map flycheck-keymap-prefix nil)
(setq flycheck-keymap-prefix (kbd "M-s M-c"))
(define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map)
;; C-c ! c flycheck-buffer
;; C-c ! p flycheck-previous-error
;; C-c ! n flycheck-next-error
;; C-c ! l flycheck-list-errors
;; C-c ! ? flycheck-describe-checker
(global-set-key (kbd "M-s c") 'flycheck-mode)
(define-key flycheck-command-map (kbd "'") 'helm-flycheck)
;; From Emacsrocks
(defun magnars/adjust-flycheck-automatic-syntax-eagerness ()
  "Adjust how often we check for errors based on if there are any.
This lets us fix any errors as quickly as possible, but in a
clean buffer we're an order of magnitude laxer about checking."
  (setq flycheck-idle-change-delay
        (if flycheck-current-errors 0.5 30.0)))
;; Each buffer gets its own idle-change-delay because of the
;; buffer-sensitive adjustment above.
(make-variable-buffer-local 'flycheck-idle-change-delay)
(add-hook 'flycheck-after-syntax-check-hook
          'magnars/adjust-flycheck-automatic-syntax-eagerness)
;; Remove newline checks, since they would trigger an immediate check
;; when we want the idle-change-delay to be in effect while editing.
(setq flycheck-check-syntax-automatically '(save
                                            idle-change
                                            mode-enabled))
(defun flycheck-handle-idle-change ()
  "Handle an expired idle time since the last change.
This is an overwritten version of the original
flycheck-handle-idle-change, which removes the forced deferred.
Timers should only trigger inbetween commands in a single
threaded system and the forced deferred makes errors never show
up before you execute another command."
  (flycheck-clear-idle-change-timer)
  (flycheck-buffer-automatically 'idle-change))
;; ================================flycheck==================================
(provide 'setup_flycheck)
