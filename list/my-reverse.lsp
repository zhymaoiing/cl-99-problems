;; P05 (*) Reverse a list.

(defun my-reverse-ite (lst)
  "reverse a list iterately"
  (labels ((inner-reverse (lst res)
             (if (null lst)
               res
               (inner-reverse (rest lst) (cons (first lst) res)))))
    (inner-reverse lst nil)))

(defun my-reverse-loop (lst)
  "reverse a list using loop"
  (loop for elem in lst with res
        do (push elem res)
        finally (return res)))

(defun test-reverse-func (reverse-func)
  (flet ((test (lst)
           (assert-equal (reverse lst) (funcall reverse-func lst))))
    (test '(1 2 3 4 5))
    (test '(1 2))
    (test '(1))
    (test '())))

;; TODO: can they be merged with a single method?
(define-test test-my-reverse-ite (test-reverse-func #'my-reverse-ite))
(define-test test-my-reverse-loop (test-reverse-func #'my-reverse-loop))

