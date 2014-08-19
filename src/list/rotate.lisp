;; P19 (**) Rotate a list N places to the left.

(in-package #:cl-99)

(defun rotate (lst step)
  ;; mod always return non-negative result for positive divisor as it uses floor 
  (if lst (let ((rem-step (mod step (length lst))))
            (apply #'append (reverse (split lst rem-step))))))
