;; P06 (*) Find out whether a list is a palindrome.

(in-package #:cl-99-test)

(define-cl-test
  #'palindrome-p
  palindrome-p
  '(((()) t)  
    (((1)) t)
    (((1 1)) t)
    (((1 2)) nil)
    (((1 1 1 1)) t)
    (((1 2 3 4 5)) nil)
    (((1 2 3 2 1)) t)
    ((("123" 3 "123")) t)
    ((("123" 3 "123" 1)) nil)
    (((1 "123" #\a "123")) nil)
    (((1 "123" #\a "123" 1)) t)
    (((1 "1" 3 "123" 1)) nil)
    (((x a m a x)) t)
    (((3 "123" #\a)) nil)))
