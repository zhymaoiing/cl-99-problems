(in-package #:cl-99-test)

;; P08 (**) Eliminate consecutive duplicates of list elements.

(define-cl-test-named my-compress (generate-cd-test-cases #'first))

;; P09 (**) Pack consecutive duplicates of list elements into sublists.

(define-cl-test-named
  my-pack
  (generate-cd-test-cases
    #'(lambda (pr) (loop repeat (second pr) collect (first pr)))))

;; P10 (*) Run-length encoding of a list.

(define-cl-tests
  '(#'run-length #'run-length-direct)
  `((run-length ,(generate-cd-test-cases #'reverse))))

;; P11 (*) Modified run-length encoding.

(define-cl-tests
  '(#'run-length* #'run-length*-direct)
  `((run-length*
     ,(generate-cd-test-cases
        #'(lambda (pr) (if (= 1 (second pr)) (first pr) (reverse pr)))))))

;; P12 (**) Decode a modified run-length encoded list.

(define-cl-test-named decode-run-length (generate-decode-cd-test-cases))
