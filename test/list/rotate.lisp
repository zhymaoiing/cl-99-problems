;; P19 (**) Rotate a list N places to the left.

(in-package #:cl-99-test)

(define-cl-test-named
  rotate
  (generate-list-test-cases
    nil
    #'(lambda (lst)
        (let* ((len (length lst))
               (step (if (= 0 len)
                       0
                       (- (* 5 len) (random (* 10 len))))))
          `(,lst ,step)))
    'verify-rotate))
