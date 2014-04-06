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

(defun test-kitchen-mode-tests-beforeall ()
  (let ((current-dir default-directory))
    (if (file-exists-p(concat(current-dir "./fixtures/test-kitchen-mode-test-run")))
        (delete-directory (concat current-dir "./fixtures/test-kitchen-mode-test-run") t)
      nil)
    (copy-directory (concat current-dir "./fixtures/test-kitchen-mode") (concat current-dir "./fixtures/test-kitchen-mode-test-run"))
    (shell-command-to-string concat("cd" (concat current-dir "./fixtures/test-kitchen-mode-test-run") ";bundle install; bundle exec berks install;"))))

(defun test-kitchen-mode-tests-afterall ()
  (let ((current-dir default-directory))
    (if (file-exists-p(concat(current-dir "./fixtures/test-kitchen-mode-test-run")))
        (delete-directory (concat current-dir "./fixtures/test-kitchen-mode-test-run") t)
      nil)))

(expectations
 (desc "success")
 (expect 10
         (+ 4 6))
 )
