;;;; cl-99.asd

(asdf:defsystem #:cl-99
  :serial t
  :description "Solution to Ninety-Nine Lisp Problems in Common Lisp"
  :version "0.0.1"
  :author "Tao Zhao <zhymaoiing@gmail.com>"
  :license "MIT"
  :depends-on (#:lisp-unit)
  :components ((:module "src"
                :components ((:file "package")
                             (:module "list"
                              :depends-on ("package")
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
               (:module "test"
                :components ((:file "test-package")
                             (:file "utility"
                              :depends-on ("test-package"))
                             (:module "list"
                              :depends-on ("test-package"
                                           "utility")
                              :components ((:file "list-simple")
                                           (:file "palindrome-p")
                                           (:file "flatten")
                                           ;                       (:file "remove-consecutive-duplicates")    
                                           ;                      (:file "pack-consecutive-duplicates")
                                           ))
                             (:file "cl-99-test"
                              :depends-on ("test-package"
                                           "list"))))))
