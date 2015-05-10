;;;; cl-99-problem.asd

(asdf:defsystem #:cl-99-problem
  :description "Solution to Ninety-Nine Lisp Problems in Common Lisp"
  :author "Tao Zhao <zhymaoiing@gmail.com>"
  :license "MIT"
  :version "0.0.2"
  :serial t
  :depends-on (#:cl-annot)
  :components ((:module "src"
                :components ((:file "utility")
                             (:file "list-utility")
                             (:file "list")))))

