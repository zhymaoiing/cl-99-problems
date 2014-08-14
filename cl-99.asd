;;;; cl-99.asd

(asdf:defsystem #:cl-99
  :serial t
  :description "Solution to Ninety-Nine Lisp Problems in Common Lisp"
  :version "0.0.1"
  :author "Tao Zhao <zhymaoiing@gmail.com>"
  :license "MIT"
  :components ((:file "cl-99")
               (:module "list"
                :depends-on ("cl-99")
                :components ((:file "my-last")
                             (:file "my-but-last")
                             (:file "my-nth")
                             (:file "my-length")
                             (:file "my-reverse")
                             (:file "palindrome-p")
                             (:file "flatten")
                             (:file "operate-on-consecutive-duplicates")
                             (:file "remove-consecutive-duplicates")
                             (:file "pack-consecutive-duplicates")))))

