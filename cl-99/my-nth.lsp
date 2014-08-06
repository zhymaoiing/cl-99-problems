(defun my-nth-rec (lst n)
  "get the nth (index from 0) element of a list recursively"
  (labels ((inner-nth-rec (lst n)
             (cond
               ((not lst) nil)
               ((= 0 n) (first lst))
               (t (inner-nth-rec (rest lst) (- n 1))))))
    (inner-nth-rec lst n)))

(defun my-nth-loop (lst n)
  "get the nth (index from 0) element of a list using loop"
  (loop for elem in lst
        for i from 0 to n
        when (= n i) return elem)) ;return nil if the condition is never met

(defun test-nth-list (nth-func lst)
  "test the given nth-func returns correct result on the lst"
  (labels ((inner-test (cur cnt)
             (if cur
               (progn
                 (assert-equal (first cur) (funcall nth-func lst cnt))
                 (inner-test (rest cur) (+ cnt 1)))
               (progn
                 (assert-equal nil (funcall nth-func lst cnt))
                 (assert-equal nil (funcall nth-func lst -1)) ;negative index
                 (assert-equal nil (funcall nth-func lst (+ cnt 10))))))) ;out of range
    (inner-test lst 0)))

(defun test-nth-func (nth-func)
  (test-nth-list nth-func '(1 2 3 4 5))
  (test-nth-list nth-func '(1 2))
  (test-nth-list nth-func '(1)) 
  (test-nth-list nth-func '()))

(define-test test-my-nth-rec (test-nth-func #'my-nth-rec))
(define-test test-my-nth-loop (test-nth-func #'my-nth-loop))
