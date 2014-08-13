(in-package :asdf-user)

(defsystem "cl-99"
  :description "Solution to Ninety-Nine Lisp Problems in Common Lisp"
  :version "0.0.1"
  :author "Tao Zhao <zhymaoiing@gmail.com>"
  :components ((:module "list"
                :components ((:file "my-last")
                             (:file "my-but-last")
                             (:file "my-nth")
                             (:file "my-length")
                             (:file "m:ls-reverse")
                             (:file "palindrome-list")
                             (:file "flatten")
                             (:file "remove-consecutive-duplicates")))))
