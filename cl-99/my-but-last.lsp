;; P02 (*) Find the last but one box of a list.

(defun my-but-last (lst)
  "get the last but one element of a list"
  (let ((rst (rest lst))) ; (rest nil) => nil
    (cond
      ((not rst) nil) ; cover nil and list with single item
      ((not (rest rst)) (first lst)) ; two items
      (t (my-but-last rst)))))

(define-test test-my-but-last
             (assert-equal 4 (my-but-last '(1 2 3 4 5)))
             (assert-equal 1 (my-but-last '(1 2)))
             (assert-equal nil (my-but-last '(1)))
             (assert-equal nil (my-but-last '())))
