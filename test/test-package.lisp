;;;; package.lisp

(defpackage #:cl-99-test
  (:use #:cl #:cl-99 #:lisp-unit)
  ;; Print parameters in test
  (:export :*print-details*
           :*print-summary* 
           :*print-failures* 
           :*print-errors*)
  ;; Print parameters in test
  (:export *cases-of-lists-tests*)
  ;; Functions for managing tests
  (:export :list-cl-99-tests
           :run-cl-99-tests))

(in-package #:cl-99-test)

(defvar *print-details* nil)

;; Test cases for list operations
(defvar *cases-of-lists-tests*
  '((1 2 3 4 5)
    (1 2)
    (1)
    ()))

(defun generate-list-test-cases (result-func)
  (loop for l in *cases-of-lists-tests*
        collect `((,l) ,(funcall result-func l))))

;; Test cases for problems on consecutive duplicates
(defvar *cases-for-consecutive-duplicates-tests*
  '((() nil)
    ((nil) ((nil 1)))
    ((1) ((1 1)))
    ((1 1) ((1 2)))
    ((1 1 1 1 1) ((1 5)))
    ((1 1 nil 1 1) ((1 2) (nil 1) (1 2)))
    ((nil 1 2 3 3) ((nil 1) (1 1) (2 1) (3 2)))
    ((1 2 3 3 nil) ((1 1) (2 1) (3 2) (nil 1)))
    ((1 1 1 1 1 2) ((1 5) (2 1)))
    (("123" "123") (("123" 2)))
    (("123" 1 1 "123") (("123" 1) (1 2) ("123" 1)))
    ((a a a a b c c a a d e e e e) ((a 4) (b 1) (c 2) (a 2) (d 1) (e 4)))
    ((a a a nil a b c c a a d e e e e) ((a 3) (nil 1) (a 1) (b 1) (c 2) (a 2) (d 1) (e 4)))))

(defun generate-consecutive-duplicate-test-cases (result-func)
  (loop for pr in *cases-for-consecutive-duplicates-tests*
        collect `((,(first pr)) ,(funcall result-func (second pr)))))
