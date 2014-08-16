;;;; package.lisp

(defpackage #:cl-99-test
  (:use #:cl #:cl-99 #:lisp-unit)
  ;; Print parameters in test
  (:export :*print-detail* 
           :*print-summary* 
           :*print-failures* 
           :*print-errors*)
  ;; Print parameters in test
  (:export :*list-test-cases*)
  ;; Functions for managing tests
  (:export :list-cl-99-tests
           :run-cl-99-tests))

