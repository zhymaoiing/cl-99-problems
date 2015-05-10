;;;; utility.lisp

(defpackage #:cl-99-test.utility
  (:use #:cl
        #:lisp-unit
        #:cl-99.utility))
(in-package #:cl-99-test.utility)

(cl-annot.syntax:enable-annot-syntax)

;;; define common utilities for cl-99 test cases

@export
(defvar *print-details* nil)

@export
(defvar *repli-limit* 8)

@export
(defmacro print-debug (&rest args)
  "Same as format, except that it only prints when *print-details* is not nil"
  `(if *print-details*
     (format t ,@args)))

@export
(defmacro print-before-return (r)
  (once-only (r)
    `(progn
       (print-debug "Print: ~A~%" ,r)
       ,r)))

;; Helper functions for testing
@export
(defun cl-test-data-p (data)
  "Test if the argument is a valid test data pair which should in the format like this:
   ((arg1 arg2 ...)) (then test-data-list must have one verify function) or
   ((arg1 arg2 ...) expect-result) or
   ((arg1 arg2 ...) :func #'verifier)"
  (print-debug "=> ~A ~A ~A ~A ~%"
               (> 3 (length data))
               (= 3 (length data))
               (equal :func (second data))
               (symbol-function-or-nil (third data)))
  (and (listp data)
       (listp (first data))
       (or (> 3 (length data))
           (and (= 3 (length data))
                (equal :func (second data))
                (symbol-function-or-nil (third data))))))

@export
(defun cl-test-data-list-p (data-list)
  "Test if the argument is a valid list of test data pair. Valid format:
   (data1 data2 ...) or
   ((data1 data2 ...) :func #'verifier)"
  (if (listp data-list)
    (flet ((is-valid (data-list)
             (loop for d in data-list always (cl-test-data-p d))))
      (if (and (= 3 (length data-list))
            (equal :func (second data-list)))
        (values
          (and (is-valid (first data-list))
               (symbol-function-or-nil (third data-list)))
          t)
        (values
          (is-valid data-list)
          nil)))))

@export
(defun call-on-list-of-pairs (pair-func data)
  "Turns data into a list of pairs, then applies the function on the pair list."
  (loop for d in data
        collect (funcall pair-func (first d) (rest d))))

@export
(defun test-cl-func (func data-list)
  "Tests the given func with data list which contains test data."
  (multiple-value-bind (valid is-func-list)
    (cl-test-data-list-p data-list)
    (if (not valid)
      (error "invalid test data list ~A" data-list))
    (let ((lst (if is-func-list (first data-list) data-list))
          (list-func (if is-func-list (symbol-function-or-nil (third data-list)) nil)))
      (flet ((verify (in res)
               (print-debug "apply ~A on ~A and verify result with ~A~%" func in (or res list-func))
               (let ((out (apply func in)))
                 (if (= 1 (length res))
                   (assert-equal (first res) out)
                   ;; verify function defined to a specific test data overrides the global one
                   (let ((verifier (or (symbol-function-or-nil (second res)) list-func)))
                     (print-debug "=> ~A ~A ~A~%" in out verifier)
                     (if (not verifier)
                       (error "no verify function defined for ~A" in)
                       (assert-true (funcall verifier in out))))))))
        (call-on-list-of-pairs #'verify lst)))))

@export
(defmacro define-cl-test (func name data-list)
  "Define a test for the given function and test data."
  `(define-test ,name (test-cl-func ,func ,data-list)))

@export
(defmacro inner-define-cl-tests (func name-data-list)
  "Genereates macro for defining multiple cl tests."
  (once-only (func name-data-list)
    `(progn 
       (print-debug ":~A ~A~%" ,func (listp ,func))
       (print-debug ".~A~%" ,name-data-list)
       ,(with-gensyms (inner-func)
          `(let ((,inner-func
                   (if (equal 'function (first ,func))
                     (list ,func)
                     ,func)))
             (if *print-details* (loop for f in ,inner-func do (format t "+ ~A~%" f)))
             `(list ,@(reduce
                        #'append
                        (call-on-list-of-pairs
                          #'(lambda (name data-list)
                              (flet ((get-case-name (i)
                                       (let ((case-name
                                               (if (< 1 (length ,inner-func))
                                                 (intern (format nil "~A-~A" name (1+ i)))
                                                 name)))
                                         (format t "+~A for ~A~%" case-name (nth i ,inner-func))
                                         case-name)))
                                (print-before-return
                                  (loop for f in ,inner-func
                                      for i from 0
                                      collect `(define-cl-test
                                                 ,f
                                                 ,(get-case-name i)
                                                 ',(first data-list))))))
                          ,name-data-list))))))))

@export
(defmacro define-cl-tests (func name-data-list)
  "Define a set of tests for the given functions and named test data."
  `(execute-macro inner-define-cl-tests ,func ,name-data-list))

@export
(defmacro define-cl-test-named (func-name &rest args)
  `(define-cl-test #',func-name ,func-name ,@args))
