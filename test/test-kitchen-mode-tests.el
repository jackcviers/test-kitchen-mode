;;; test-kitchen-mode-tests.el --- Test-Kitchen-Mode's tests -*- lexical-binding: t -*-

;; Copyright (C) 2014  Jack C. Viers

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License along
;; with this program; if not, write to the Free Software Foundation, Inc.,
;; 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


;;; Code:
(require 'cl)
(add-to-list 'load-path (expand-file-name "../"))
(require 'ert)
(require 'el-mock nil t)
(require 'ert-expectations)
(require 'test-kitchen-mode)

;;; bundler will always ask for a password. Until I figure out how to make this work
;;; via automated test-setup and test-teardown, create the test-run-directory yourself
;;; by executing `cp -r ./fixtures-test-kitchen-mode-test ./fixtures-test-kitchen-mode-test-run; bundle install; berks install` in the terminal.

;;; uncomment when figured out how to get password to bundler in `call-process-shell-command`
;; (defun delete-and-generate-test-run-dir-with-buffer (current-dir generated-buffer)
;;   (if (file-exists-p (concat current-dir "./fixtures/test-kitchen-mode-test-run"))
;;         (delete-directory (concat current-dir "./fixtures/test-kitchen-mode-test-run") t)
;;         nil)
;;         (copy-directory (concat current-dir "./fixtures/test-kitchen-mode") (concat current-dir "./fixtures/test-kitchen-mode-test-run"))
;;         (display-buffer generated-buffer '((display-buffer . nil)) nil)
;;         (call-process-shell-command (concat"cd " (concat current-dir "./fixtures/test-kitchen-mode-test-run") "; bundle install; bundle exec berks install;") nil generated-buffer t))

;; (defun test-kitchen-mode-tests-beforeall ()
;;   (let ((current-dir default-directory)
;;       (generated-buffer (generate-new-buffer "*test-kitchen-test-setup*")))
;;       (delete-and-generate-test-run-dir-with-buffer current-dir generated-buffer)))

;; (defun test-kitchen-mode-tests-beforeall ()
;;   (let ((current-dir default-directory))
;;     (copy-directory (concat current-dir "./fixtures/test-kitchen-mode") (concat current-dir "./fixtures-test-kitchen-mode-test-run"))))

;; (defun test-kitchen-mode-tests-afterall ()
;;   (let ((current-dir default-directory))
;;     (if (file-exists-p (concat current-dir "./fixtures/test-kitchen-mode-test-run"))
;;         (delete-directory (concat current-dir "./fixtures/test-kitchen-mode-test-run") t)
;;       nil)))

;;; set up the test beforehand!

(expectations
  (desc "(+ 4 6) => 10")
  (expect 10
    (+ 4 6))
  (desc "calling test-kitchen-dired-open-suite-at-point in the .kitchen.yml file
        should return a buffer with the name 'test-kitchen-mode/test/integration/default/serverspec'")
  (let ((yml-buffer (find-file (concat default-directory "./fixtures/test-kitchen-mode/.kitchen.yml"))))
    (goto-char (point-min))
    (re-search-forward "default$")
    (expect "test-kitchen-mode-test/test/integration/default/serverspec" (let ((actual-buffer '(call-interactively test-kitchen-dired-open-suite-at-point))
                                                                                   (name (buffer-name 'actual-buffer)))
                                                                               (kill-buffer 'actual-buffer)
                                                                               (name)))
    (kill-buffer yml-buffer)))


  (let ((yml-buffer (find-file (concat default-directory "./fixtures/test-kitchen-mode/.kitchen.yml"))))
    (goto-char (point-min))
    (re-search-forward "default$")
    (buffer-name (test-kitchen-dired-open-suite-at-point))
    ;; (let ((actual-buffer (call-interactively 'test-kitchen-dired-open-suite-at-point))
    ;;                                                                                (name (buffer-name 'actual-buffer)))
    ;;                                                                            (kill-buffer 'actual-buffer)
    ;;                                                                            (name))
    ;; (kill-buffer yml-buffer)
    )
