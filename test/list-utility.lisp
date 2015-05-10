;;;; list-utility.lisp

(defpackage #:cl-99-test.list.utility
  (:use #:cl))
(in-package #:cl-99-test.list.utility)

(cl-annot.syntax:enable-annot-syntax)

;;; define common utilities related to lists for cl-99 test cases

;; Test cases for list operations
@export
(defvar *cases-of-lists-tests*
  '((1 2 3 4 5)
    (1 2)
    (5 5 5)
    (1)
    ("123" 2 "123" x 1.0 y z nil :lalala)
    ()))

@export
(defun generate-list-test-cases (&optional result-func generator verifier-name)
  "Generate test cases for list testing based on given functions. Note that verifier should be given a name symbol instead of the function itself because function objects cannot be dumped into fasl files."
  (let* ((my-func (or generator #'list))
         (data-list (loop for l in *cases-of-lists-tests*
                          collect (cons (funcall my-func l)
                                        (if result-func `(,(funcall result-func l)) nil)))))
    (if verifier-name
      `(,data-list :func ,verifier-name)
      data-list)))

@export
(defun generate-list-test-cases-func-gen (func-gen)
  (loop for l in *cases-of-lists-tests*
        collect (multiple-value-bind (generator verifier) (funcall func-gen)
                  (let ((func (or generator #'list)))
                    (if verifier
                      `(,(funcall func l) :func ,verifier))))))

;; Test cases for problems on consecutive duplicates
@export
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
    ((a a a nil a b c c a a d e e e e) ((a 3) (nil 1) (a 1) (b 1) (c 2) (a 2) (d 1) (e 4))))
  "Define the cases for testing of consecutive duplicates in the format:
   (<input list to the function> ((<elem1> <count of elem1>) (elem2 <count of elem2>) ...))")

@export
(defun generate-cd-test-cases (result-func)
  "Generate test cases for testing of consecutive duplicates."
  (loop for pr in *cases-for-consecutive-duplicates-tests*
        collect `((,(first pr))
                  ,(loop for dup in (second pr)
                         collect (funcall result-func dup)))))

@export
(defun generate-decode-cd-test-cases ()
  "Generate test cases for testing of decoding consecutive duplicates."
  (loop for pr in *cases-for-consecutive-duplicates-tests*
        collect `((,(mapcar #'reverse (second pr))) ,(first pr))))