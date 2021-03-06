;;; wicd-mode
;; ================wicd-mode=================
(def-package! wicd-mode
  :load-path "site-lisp/wicd-mode/"
  :bind ("C-M-$" . wicd)
  :config
  (setq wicd-wireless-max-id 100)
  (defvar dbus-object-end-scan nil)
  (defvar dbus-object-start-scan nil)
  (defvar dbus-object-connect nil)
  ;; 解决wicd关闭后仍然刷新wicd的问题。
  ;; 源程序在加载文件时创建signal，其后并不关闭。
  ;; 现在更改为启动wicd-mode时创建signal，退出时注销signal。
  ;; 同时注释掉源文件中dbus-register-signal相关项。
  ;; 可以使用dbus-registered-objects-table查看当前signals。
  (defun dbus-register-objects-for-wicd-mode ()
    "Redisplay wireless network list."
    (interactive)
    (setq dbus-object-end-scan (dbus-register-signal
                                :system
                                wicd-dbus-name
                                (wicd-dbus-path :wireless)
                                (wicd-dbus-name :wireless)
                                "SendEndScanSignal"
                                (lambda ()
                                  (setq wicd-wireless-scanning nil)
                                  (run-hooks 'wicd-wireless-scan-hook))))
    (setq dbus-object-start-scan (dbus-register-signal
                                  :system
                                  wicd-dbus-name
                                  (wicd-dbus-path :wireless)
                                  (wicd-dbus-name :wireless)
                                  "SendStartScanSignal"
                                  (lambda ()
                                    (setq wicd-wireless-scanning t)
                                    (with-current-buffer (wicd-buffer)
                                      (let (buffer-read-only)
                                        (erase-buffer)
                                        (insert "Scanning…\n"))))))
    (setq dbus-object-connect (dbus-register-signal
                               :system
                               wicd-dbus-name
                               (wicd-dbus-path :daemon)
                               (wicd-dbus-name :daemon)
                               "ConnectResultsSent"
                               (lambda (s)
                                 (message "Connexion %s" s)
                                 (when (string= s "success")
                                   (wicd-wireless-emphase-network))))))
  (defun quit-wicd-mode ()
    "Redisplay wireless network list."
    (interactive)
    (kill-buffer-and-window)
    (dbus-unregister-object dbus-object-end-scan)
    (dbus-unregister-object dbus-object-start-scan)
    (dbus-unregister-object dbus-object-connect))
  (add-hook 'wicd-mode-hook 'dbus-register-objects-for-wicd-mode)
  (define-key wicd-mode-map (kbd "q") 'quit-wicd-mode))
;; ================wicd-mode=================
(provide 'setup_wicd)
