;;;; define tests on duplicate operatoins on list

(in-package #:cl-99-test)

;; P14 (*) Duplicate the elements of a list.

(define-cl-test-named
  my-dupli
  (generate-list-test-cases
    nil
    nil
    'verify-duplicate))

;; P15 (**) Replicate the elements of a list a given number of times.

(define-cl-test-named
  my-repli
  (generate-list-test-cases-func-gen
    #'(lambda ()
        ;; zero times is not invalid
        (let ((repli-cnt (1+ (random *repli-limit*))))
          (values
            #'(lambda (x) `(,x ,repli-cnt))
            'verify-replicate)))))
