#!/usr/bin/sbcl --script

;; LIMIT: 100000000000000000000000000000000000000

(defvar TRACK 0)


(defun markov (lower upper)
    (gen_markov_sequence lower upper 1 1 1)
)

(defun gen_markov_sequence (lower upper a b c)
    (if (> c upper) (return-from gen_markov_sequence 0))
    (if (< c lower)
        (if (<= c 2)
            (return-from gen_markov_sequence 
                (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) ) 
            (return-from gen_markov_sequence 
            (+  (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) 
                (gen_markov_sequence lower upper b c (- (* 3 (* b c)) a)) ) )
        )
    )

    (setf TRACK (+ TRACK 1))

    (if (<= c 2)
        (return-from gen_markov_sequence (+ c
            (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) ) )
        (return-from gen_markov_sequence (+ c
        (+  (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) 
            (gen_markov_sequence lower upper b c (- (* 3 (* b c)) a)) ) ) )
    )
)

;; CURRENTLY RETURNS A FLOAT
(defun collapse (val) (let ((sum 0))
    (if (< val 10) (return-from collapse val)) ;; BASE CASE

    (loop while (< 0 val) do
        (setf sum (+ sum (mod val 10)))
        (setf val (ftruncate val 10))
    ) ;; END INNER LOOP

    (collapse sum)
)) ;; END FUNCTION COLLAPSE

;; WORK WITH STRINGS
(defun toRoman (val) (let ((output ""))
    (if (= val 0) (setf output "N"))
    (loop while (< 0 val) do 
        (if (<= 9 val)(progn
            (setf output (concatenate 'string output "IX"))
            (setf val (- val 9)))
        (if (<= 5 val) (progn        ;else 1
            (setf output (concatenate 'string output "V"))
            (setf val (- val 5)))
        (if (<= 4 val) (progn       ;else 2
            (setf output (concatenate 'string output "IV"))
            (setf val (- val 4)))
        (progn                      ;else 3
            (setf output (concatenate 'string output "I"))
            (setf val (- val 1))
        ))))
    )
    output
))

;;;;;;;;;;;;;;;;;;;;;;; MAIN ;;;;;;;;;;;;;;;;;;;;;;;
(let ((LOWER_BOUND 0)
      (UPPER_BOUND 0)
      (sum         0)
      (col         0)
    )

    (setf LOWER_BOUND (parse-integer (nth 1 *posix-argv*)))
    (setf UPPER_BOUND (parse-integer (nth 2 *posix-argv*)))
    (if (< UPPER_BOUND LOWER_BOUND) (rotatef LOWER_BOUND UPPER_BOUND)) ;; Swap

    (setf sum (markov LOWER_BOUND UPPER_BOUND))
    (setf col (truncate (collapse sum)))

    (format t "   Count: ~d~%" TRACK)
    (format t "     Sum: ~d~%" sum)
    (format t "Collapse: ~d~%" col)
    (format t "   Roman: ~a~%" (toRoman col))
    (if (= 0 (mod col 2))
        (format t "  --Hail Caesar!~%")
        (format t "  --et tu Brute!~%")
    )
)