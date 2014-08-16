;;;; cl-99-test.lisp

(in-package #:cl-99-test)

(defvar *print-details*)

(defvar *this-package* (find-package 'cl-99-test))

(defun list-cl-99-tests ()
  (list-tests *this-package*))

(defun run-cl-99-tests
  (&optional
    ;; TODO: support pattern search on test names
    (test-names :all)
    (*print-details* 1)
    (*print-summary* 1) 
    (*print-failures* 1) 
    (*print-errors* 1))
  (run-tests test-names *this-package*))

(run-cl-99-tests)
