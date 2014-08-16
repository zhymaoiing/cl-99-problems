(in-package #:cl-99-test)

;; P08 (**) Eliminate consecutive duplicates of list elements.

(define-cl-test
  #'remove-consecutive-duplicates
  compress
  (generate-consecutive-duplicate-test-cases
    #'(lambda (lst)
        (loop for pr in lst
              collect (first pr)))))

;; P09 (**) Pack consecutive duplicates of list elements into sublists.

(define-cl-test
  #'pack-consecutive-duplicates
  pack
  (generate-consecutive-duplicate-test-cases
    #'(lambda (lst)
        (loop for pr in lst
              collect (loop repeat (second pr)
                            collect (first pr))))))

;; P10 (*) Run-length encoding of a list.

(define-cl-tests
  '(#'length-consecutive-duplicates #'length-consecutive-duplicates-pre)
  `((encode
     ,(generate-consecutive-duplicate-test-cases
        #'(lambda (lst)
            (loop for pr in lst
                  collect (reverse pr)))))))

;; P11 (*) Modified run-length encoding.

(define-cl-tests
  '(#'length-consecutive-duplicates-modified #'length-consecutive-duplicates-modified-pre)
  `((encode*
     ,(generate-consecutive-duplicate-test-cases
        #'(lambda (lst)
            (loop for pr in lst
                  collect (if (= 1 (second pr)) (first pr) (reverse pr))))))))
