;; P08 (**) Eliminate consecutive duplicates of list elements.

(in-package #:cl-99-test)

;: TODO: add a utility for this
(defun test-func (func data)
  (flet ((test (pr)
           (destructuring-bind (lst res) pr
             (assert-equal res (funcall func lst)))))
    (mapcar #'test data)))

(defun test-compress-func (data)
  (test-func #'remove-consecutive-duplicates data))

(define-test test-compress
             (test-compress-func '((() nil)
                                   ((nil) (nil))
                                   ((1) (1))
                                   ((1 1) (1))
                                   ((1 1 1 1 1) (1))
                                   ((1 1 nil 1 1) (1 nil 1))
                                   ((nil 1 2 3 3) (nil 1 2 3))
                                   ((1 2 3 3 nil) (1 2 3 nil))
                                   ((1 1 1 1 1 2) (1 2))
                                   (("123" "123") ("123"))   
                                   (("123" 1 1 "123") ("123" 1 "123"))
                                   ((a a a a b c c a a d e e e e) (a b c a d e))   
                                   ((a a a nil a b c c a a d e e e e) (a nil a b c a d e)))))
