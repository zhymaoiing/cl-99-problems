;; P06 (*) Find out whether a list is a palindrome.

(defun palindrome-p (lst)
  "test if the given list is palindrome"
  (equal lst (reverse lst)))

(defun test-reverse-func (func)
  (flet ((test (lst res)
           (assert-equal res (funcall func lst))))
    (test '() t)  
    (test '(1) t)
    (test '(1 1) t)
    (test '(1 2) nil)
    (test '(1 1 1 1) t)
    (test '(1 2 3 4 5) nil)
    (test '(1 2 3 2 1) t)
    (test '("123" 3 "123") t)
    (test '("123" 3 "123" 1) nil)
    (test '(1 "123" #\a "123") nil)
    (test '(1 "123" #\a "123" 1) t)
    (test '(1 "1" 3 "123" 1) nil)
    (test '(x a m a x) t)
    (test '(3 "123" #\a) nil)))

;; TODO: can they be merged with a single method?
(define-test test-palindrome (test-reverse-func #'palindrome-p))

