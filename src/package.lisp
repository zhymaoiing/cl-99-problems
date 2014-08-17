;;;; cl-99.lisp

(defpackage #:cl-99
  (:use #:cl)
  ;; symbols for list operations
  ;; TODO: merge multiple symbols about the same problem to a single one which might represents a list of all previous symbols
  (:export :my-last
           :my-but-last
           :my-nth-rec
           :my-nth-loop
           :my-length-rec
           :my-length-ite
           :my-length-loop
           :my-reverse-ite
           :my-reverse-loop
           :palindrome-p
           :flatten
           :my-compress
           :my-pack
           :run-length
           :run-length-direct
           :run-length*
           :run-length*-direct
           :decode-run-length
           :my-dupli
           :my-repli
           :drop-rec
           :drop-ite
           :drop-loop
           )
  ;; Utility symbols
  (:export :with-gensyms
           :once-only
           :execute-macro
           :duplicate
           :join
           :symbol-function-or-nil
           ))
