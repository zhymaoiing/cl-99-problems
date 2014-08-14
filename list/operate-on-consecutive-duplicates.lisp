(in-package #:cl-99)

(defun operate-on-consecutive-duplicates (lst init-func aggr-func)
  "perform operations on consecutive duplicates in the given list
   init-func takes a non-nil list and returns the initial value to aggregate
   aggr-func takes two arguments in which the first one is the result 
        previously generated, and the second one is to be aggregated"
  (if (null lst) 
    nil
    (nreverse (reduce aggr-func
                      (rest lst) ;avoid case like (list nil)
                      :initial-value (funcall init-func lst)))))
