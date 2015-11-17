;; =================winner-mode=================
(use-package winner
  ;; Enabled at commands.
  :defer 2
  :bind (("M-/" . winner-undo)
         ("M-s M-/" . winner-redo))
  :config
  (winner-mode 1))
;; =================winner-mode=================
;; =================window-numbering=================
(use-package window-numbering
  ;; Enabled automatically.
  :config
  (window-numbering-mode 1)
  ;; 当按键大于现有窗口数目时，选中最后一个窗口
  (defvar previously-selected-window nil
    "previously-selected-window.")
  (defun select-window-by-number (i &optional arg)
    "Select window given number I by `window-numbering-mode'.
If prefix ARG is given, delete the window instead of selecting it."
    (interactive "P")
    (let ((windows (car (gethash (selected-frame) window-numbering-table)))
          window)
      (if (and (>= i 0) (< i 10)
               (setq window (aref windows i)))
          ()
        (setq window (aref windows (- (car window-numbering-left) 1))))
      (setq previously-selected-window (selected-window))
      (if arg
          (delete-window window)
        (select-window window))))
  (define-key window-numbering-keymap (kbd "C-1") 'select-window-1)
  (define-key window-numbering-keymap (kbd "C-2") 'select-window-2)
  (define-key window-numbering-keymap (kbd "C-3") 'select-window-3)
  (define-key window-numbering-keymap (kbd "C-4") 'select-window-4)
  (define-key window-numbering-keymap (kbd "C-5") 'select-window-5)
  (define-key window-numbering-keymap (kbd "C-6") 'select-window-0)
  (defun transpose-window-by-number (i &optional arg)
    "Transpose the buffers shown in two windows."
    (interactive "p")
    (let ((windows (car (gethash (selected-frame) window-numbering-table)))
          (this-win (window-buffer))
          window)
      (if (and (>= i 0) (< i 10)
               (setq window (aref windows i)))
          ()
        (setq window (aref windows (- (car window-numbering-left) 1))))
      (set-window-buffer (selected-window) (window-buffer window))
      (set-window-buffer window this-win)
      (select-window window)))
  (dotimes (i 10)
    (eval `(defun ,(intern (format "transpose-window-%s" i)) (&optional arg)
             ,(format "Transpose the window with number %i." i)
             (interactive "P")
             (transpose-window-by-number ,i arg))))
  (define-key window-numbering-keymap (kbd "C-!") 'transpose-window-1)
  (define-key window-numbering-keymap (kbd "C-@") 'transpose-window-2)
  (define-key window-numbering-keymap (kbd "C-#") 'transpose-window-3)
  (define-key window-numbering-keymap (kbd "C-$") 'transpose-window-4)
  (define-key window-numbering-keymap (kbd "C-%") 'transpose-window-5)
  (define-key window-numbering-keymap (kbd "C-^") 'transpose-window-0)
  (defun select-previously-selected-window ()
    "Select previously selected window."
    (interactive)
    (let ((current-selected-window (selected-window)))
      (if (and
           (memq previously-selected-window (window-list) ;; (append (car (gethash (selected-frame) window-numbering-table)) nil)
                 ) ;之前选择window在当前window列表中
           (not (equal previously-selected-window (selected-window)))) ;之前选择window与当前window不同
          (select-window previously-selected-window)
        (other-window 1))
      (setq previously-selected-window current-selected-window)))
  (defun transpose-with-previously-selected-window ()
    "Select previously selected window."
    (interactive)
    (let ((current-selected-window (selected-window))
          (this-win (window-buffer)))
      (if (and
           (memq previously-selected-window (window-list) ;; (append (car (gethash (selected-frame) window-numbering-table)) nil)
                 ) ;之前选择window在当前window列表中
           (not (equal previously-selected-window (selected-window)))) ;之前选择window与当前window不同
          (progn (set-window-buffer (selected-window) (window-buffer previously-selected-window))
                 (set-window-buffer previously-selected-window this-win)
                 (select-window previously-selected-window))
        (progn (set-window-buffer (selected-window) (window-buffer (next-window)))
               (set-window-buffer (next-window) this-win)
               (other-window 1)))
      (setq previously-selected-window current-selected-window)))
  (global-set-key (kbd "C-<tab>") 'select-previously-selected-window)
  (cond
   (is-lin (global-set-key (kbd "<C-S-iso-lefttab>") 'transpose-with-previously-selected-window))
   (is-win (global-set-key (kbd "C-S-<tab>") 'transpose-with-previously-selected-window))))
;; =================window-numbering=================
;; =====================switch-window======================
(use-package switch-window
  ;; Enabled at commands.
  :defer t
  :bind ("C-x o" . switch-window))
;; =====================switch-window======================
;; =====================windmove=====================
(use-package windmove
  ;; Enabled at commands.
  :defer t
  :commands (windmove-left windmove-right windmove-up windmove-down)
  :init
  (smartrep-define-key global-map "M-s"
    '(("h" . swint-windmove-left)
      ("l" . swint-windmove-right)
      ("k" . swint-windmove-up)
      ("j" . swint-windmove-down)))
  (defun ignore-error-wrapper (fn)
    "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
    (lexical-let ((fn fn))
      (lambda ()
        (interactive)
        (ignore-errors
          (funcall fn)))))
  (defun swint-windmove-left ()
    "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
    (interactive)
    (setq previously-selected-window (selected-window))
    (funcall (ignore-error-wrapper 'windmove-left)))
  (defun swint-windmove-right ()
    "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
    (interactive)
    (setq previously-selected-window (selected-window))
    (funcall (ignore-error-wrapper 'windmove-right)))
  (defun swint-windmove-up ()
    "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
    (interactive)
    (setq previously-selected-window (selected-window))
    (funcall (ignore-error-wrapper 'windmove-up)))
  (defun swint-windmove-down ()
    "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
    (interactive)
    (setq previously-selected-window (selected-window))
    (funcall (ignore-error-wrapper 'windmove-down))))
;; =====================windmove=====================
;; ====================三窗口设置=====================
(defun split-window-3-horizontally (&optional arg)
  "Split window into 3 while largest one is in horizon"
  ;; (interactive "P")
  (delete-other-windows)
  (split-window-horizontally)
  (if arg (other-window 1))
  (split-window-vertically))
(defun split-window-3-vertically (&optional arg)
  "Split window into 3 while largest one is in vertical"
  ;; (interactive "P")
  (delete-other-windows)
  (split-window-vertically)
  (if arg (other-window 1))
  (split-window-horizontally))
(defun change-split-type (split-fn &optional arg)
  "Change 3 window style from horizontal to vertical and vice-versa"
  (let ((bufList (mapcar 'window-buffer (window-list))))
    (select-window (get-largest-window))
    (funcall split-fn arg)
    (mapcar* 'set-window-buffer (window-list) bufList)))
(defun change-split-type-3-v (&optional arg)
  "change 3 window style from horizon to vertical"
  (interactive "P")
  (change-split-type 'split-window-3-horizontally arg))
(defun change-split-type-3-h (&optional arg)
  "change 3 window style from vertical to horizon"
  (interactive "P")
  (change-split-type 'split-window-3-vertically arg))
;; ====================三窗口设置=====================
(provide 'setup_windows)
