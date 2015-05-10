;;;; run.lisp

;;; run the test cases defined for cl-99 problems

(in-package #:cl-99-test.list.cases)

(ql:quickload 'lisp-unit)

(defvar *this-package* (find-package 'cl-99-test.list.cases))

(lisp-unit:list-tests *this-package*)

(lisp-unit:run-tests :all *this-package*)
