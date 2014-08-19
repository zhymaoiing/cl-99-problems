(in-package #:cl-99-test)

;; P16 (**) Drop every N'th element from a list.

(define-cl-test-named
  drop-loop
  (generate-list-test-cases
    nil
    #'(lambda (lst) `(,lst ,(1+ (let ((len (length lst)))
                                  (if (= 0 len) 0 (random len))))))
    'verify-drop))

;; P20 (*) Remove the K'th element from a list.

(define-cl-tests
  '(#'remove-at-rec #'remove-at-ite #'remove-at-loop)
  `((remove-at
      ,(generate-list-test-cases
         nil
         #'(lambda (lst) `(,lst ,(random (+ 10 (length lst)))))
         'verify-remove-at))))
