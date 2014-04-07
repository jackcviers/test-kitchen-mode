;;; test-kitchen-mode.el --- Test-Kitchen-Mode -*- lexical-binding: t -*-

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
(require 'ruby-mode)
(require 'compile)
(require 'cl-lib)

(define-prefix-command 'test-kitchen-mode-verifilable-keymap)
(define-prefix-command 'test-kitchen-mode-keymap)
(defgroup test-kitchen-mode nil
  "TestKitchen minor mode."
  :group 'languages)

(defcustom test-kitchen-use-rake-when-possible t
  "When non-nil and Rakefile is present, run specs via rake spec task."
  :tag "TestKitchen runner command"
  :type '(radio (const :tag "Use 'rake spec' task" t)
                (const :tag "Use 'spec' command" nil))
  :group 'test-kitchen-mode)

(defcustom test-kitchen-rake-command "rake"
  "The command for rake"
  :type 'string
  :group 'test-kitchen-mode)

(defcustom test-kitchen-init-command "kitchen init"
  "The command for initializing test-kitchen"
  :type 'string
  :group 'test-kitchen-mode)

(defcustom test-kitchen-list-command "kitchen list"
  "The command for listing available test-kitchen instances"
  :type 'string
  :group 'test-kitchen-mode)

(defcustom test-kitchen-converge-command "kitchen converge"
  "The command for converging a test-kitchen instance"
  :type 'string
  :group 'test-kitchen-mode)

(defcustom test-kitchen-destroy-command "kitchen destroy"
  "The command for destroying test-kitchen instances"
  :type 'string
  :group 'test-kitchen-mode)

(defcustom test-kitchen-test-command "kitchen test"
  "The command for testing test-kitchen instances"
  :type 'string
  :group 'test-kitchen-mode)

(defcustom test-kitchen-use-rvm nil
  "When t, use RVM. Requires rvm.el"
  :type 'boolean
  :group 'test-kitchen-mode)

(defcustom test-kitchen-use-bundler-when-possible t
  "When t and Gemfile is present, run test-kitchen with 'bundle exec'."
  :type 'boolean
  :group 'test-kitchen-mode)

(defcustom test-kitchen-key-command-prefix (kbd "C-c .")
  "The prefix for all test-kitchen related key commands"
  :type 'string
  :group 'test-kitchen-mode)

;;;###autoload
(define-minor-mode test-kitchen-mode
  "Minor mode for test-kitchen files"
  :lighter " Test-Kitchen"
  :keymap `((,test-kitchen-key-command-prefix . test-kitchen-mode-keymap))
  (if test-kitchen-mode
      (progn
        (test-kitchen-set-imenu-generic-expression)
        (setq imenu-create-index-function 'ruby-imenu-create-index)
        (setq imenu-generic-expression nil)
        )))

;;;###autoload
(define-minor-mode test-kitchen-dired-mode
  "Minor mode for Dired buffers with spec files"
  :lighter ""
  :keymap `((,test-kitchen-key-command-prefix . test-kitchen-mode-verifilable-keymap)))

(defconst test-kitchen-imenu-generic-expression
  '(("Examples" "^\\( *\\(it\\|describe\\) +.+\\)"        1))
  "The imenu regex to parse an outline of the serverspec file")

(defconst test-kitchen-spec-file-name-re "\\(_\\|-\\)spec\\.rb\\'"
  "The regex to identify spec files")

(defconst test-kitchen-suites-re "^suites:")
(defconst test-kitchen-name-parameter-re "- name:")

(defun test-kitchen-set-imenu-generic-expression ()
  (make-local-variable 'imenu-generic-expression)
  (make-local-variable 'imenu-create-index-function)
  (setq imenu-create-index-function 'imenu-default-create-index-function)
  (setq imenu-generic-expression test-kitchen-imenu-generic-expression))


(defun test-kitchen-spec-directory (suite-name)
  "Returns the nearest directory that contains the specs for a suite contained in the current buffer"
  (if (file-exists-p (concat
                (test-kitchen-root-directory
                 (buffer-file-name current-buffer))
                (file-relative-name
                 (test-kitchen-root-directory
                  (buffer-file-name current-buffer))
                 (concat "test/integration/" suite-name))))
      (file-name-as-directory (concat
                (test-kitchen-root-directory
                 (buffer-file-name current-buffer))
                (file-relative-name
                 (test-kitchen-root-directory
                  (buffer-file-name current-buffer))
                 (concat "test/integration/" suite-name))))))

(defun test-kitchen-get-suite-name-at-point ()
  "Returns the suite"
  (interactive)
  (let ((suite-name (thing-at-point 'sexp))
        (cursor-position (point))
        (cursor-beginning-of-line (beginning-of-line))
        (line-number (call-interactively 'what-line))
        (suites-line (test-kitchen-find-suites-line)))
    (if (and (< suites-line line-number) (>= cursor-position-beginning-of-line (re-search-backward test-kitchen-name-parameter-re)))
        (test-kitchen-return-to-char-and-return-string cursor-position suite-name)
      nil)))


;;;autoload
(defun test-kitchen-dired-open-suite-at-point ()
  "Opens the directory containing the suite name at point, if it is a suite-name"
  (interactive)
  (let ((suite-name-at-point (call-interactively test-kitchen-get-suite-name-at-point)))
    (if (suite-name)
        (find-file (test-kitchen-spec-directory suite-name)))))

(defun test-kitchen-return-to-char-and-return-string (pos str)
  (goto-char pos)
  (str))

(defun test-kitchen-find-suites-line ()
  (goto-char (point-min))
  (re-search-forward test-kitchen-suites-re)
  (call-interactively 'what-line))


(provide 'test-kitchen-mode)
