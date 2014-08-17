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
                             (:file "utility")
                             (:module "list"
                              :depends-on ("package"
                                           "utility")
                              :components ((:file "my-last")
                                           (:file "my-but-last")
                                           (:file "my-nth")
                                           (:file "my-length")
                                           (:file "my-reverse")
                                           (:file "palindrome-p")
                                           (:file "flatten")
                                           (:file "my-compress")
                                           (:file "my-pack")
                                           (:file "run-length"
                                            :depends-on ("my-pack"))
                                           (:file "run-length-modified"
                                            :depends-on ("run-length"))
                                           (:file "decode-run-length")
                                           (:file "my-duplicate")
                                           (:file "drop")
                                           ))))
               (:module "test"
                :depends-on ("src")
                :components ((:file "test-package")
                             (:file "test-utility"
                              :depends-on ("test-package"))
                             (:module "list"
                              :depends-on ("test-package"
                                           "test-utility")
                              :components ((:file "list-simple")
                                           (:file "palindrome-p")
                                           (:file "flatten")
                                           (:file "consecutive-duplicates")
                                           (:file "list-duplicate")
                                           (:file "list-drop")
                                           ))
                             (:file "cl-99-test"
                              :depends-on ("test-package"
                                           "test-utility"
                                           "list"))))))
