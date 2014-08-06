(defun my-length-rec (lst)
  "get the length of a list recursively"
  (if (null lst)
    0
    (1+ (my-length-rec (rest lst)))))

(defun my-length-ite (lst)
  "get the length of a list iterately"
  (labels ((inner-length (lst n)
             (if (null lst)
               n
               (inner-length (rest lst) (1+ n)))))
    (inner-length lst 0)))

(defun my-length-loop (lst)
  "get the length of a list using loop"
  (loop for elem in lst count elem))

(defun test-length-func (nth-func)
  (flet ((test (lst)
           (assert-equal (length lst) (funcall nth-func lst))))
    (test '(1 2 3 4 5))
    (test '(1 2))
    (test '(1))
    (test '())))

;; TODO: can they be merged with a single method?
(define-test test-my-length-rec (test-length-func #'my-length-rec))
(define-test test-my-length-ite (test-length-func #'my-length-ite))
(define-test test-my-length-loop (test-length-func #'my-length-loop))

