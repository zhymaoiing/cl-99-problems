(defun my-last (lst)
  "get the lst element of a list"
  (cond
    ((not lst) nil)
    ((not (rest lst)) (first lst))
    (t (my-last (rest lst)))))

(define-test test-my-last
             (assert-equal 5 (my-last '(1 2 3 4 5)))
             (assert-equal 1 (my-last '(1)))
             (assert-equal nil (my-last '())))
