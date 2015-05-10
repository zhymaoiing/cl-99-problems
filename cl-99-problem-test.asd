;;;; cl-99-problem-test.asd

(asdf:defsystem #:cl-99-problem-test
  :description "Test of the Solution to Ninety-Nine Lisp Problems in Common Lisp"
  :author "Tao Zhao <zhymaoiing@gmail.com>"
  :license "MIT"
  :version "0.0.2"
  :serial t
  :depends-on (#:cl-annot
               #:lisp-unit
               #:cl-99-problem)
  :components ((:module "test"
                :components ((:file "utility")
                             (:file "list-utility")
                             (:file "list-verify")
                             (:file "list-cases")
                             (:file "run")))))

