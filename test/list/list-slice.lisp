;; P18 (**) Extract a slice from a list.

(in-package #:cl-99-test)

(define-cl-test-named
  slice
  (generate-list-test-cases
    nil
    #'(lambda (lst)
        (let ((len (length lst)))
          (flet ((gen-index () (if (= 0 len) 0 (1+ (random len)))))
            (let ((a (gen-index))
                  (b (gen-index)))
              `(,lst ,(min a b) ,(max a b))))))
    'verify-slice))
