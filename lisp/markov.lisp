#!/usr/bin/sbcl --script

;; GLOBALS - able to accessed and modified from within the 
;; recursive function gen_markov_sequence
(defvar TRACK 0)            ;; Counter that tracks the number of markovs found
(defvar markovElements '()) ;; List which holds all markov numbers in given range

;;;; markov (<int> <int>)
;; PARAMS: Two integers, upper and lower, which determine the range
;; RETURN: Returns the sum of every Markov number within the given range
;; BEHAVIOR: Helper function that calls gen_markov_sequence with the correct
;; intial parameters. It also manages the list by sorting and returning a 
;; formatted sum.
(defun markov (lower upper) (let ((sum))
    (setf sum (gen_markov_sequence lower upper 1 1 1))

    (sort markovElements #'>)
    (setf markovElements (reverse markovElements))

    (return-from markov (truncate sum))
))

;;;; gen_markov_sequence (<int> <int> <int> <int> <int>)
;; PARAMS: The first two integers determine the range. These correspond to the same
;; inputs sent into the (markov) function. The remaining three integers - a, b, and c - 
;; correspond to a Markov triple. 
;; RETURN: Returns the sum of every Markov number within the given range. 
;; BEHAVIOR: Modifies the markovElements list. Pushes each new found Markov number to the 
;; list which can later be accessed in the main procedure.
;; Recursively generates a Markov sequence based on triples. There are two recursive calls
;; to both the "top" and "bottom branch" and calculate the next markov triple by calculating
;; a new "c" value with either the formula 3*a*c-b or 3*b*c-a. Runs until the incoming "c"
;; value exceeds the upper bound. 
(defun gen_markov_sequence (lower upper a b c)
    (if (> c upper) (return-from gen_markov_sequence 0))
    (if (< c lower)
        (if (<= c 2)
            (return-from gen_markov_sequence 
                (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b))   ) 
            (return-from gen_markov_sequence (+
                (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) 
                (gen_markov_sequence lower upper b c (- (* 3 (* b c)) a)) ) )
        )
    )

    (push c markovElements)
    (setf TRACK (+ TRACK 1))

    (if (<= c 2)
        (return-from gen_markov_sequence (+ c
            (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) ) )
        (return-from gen_markov_sequence (+ c (+  
            (gen_markov_sequence lower upper a c (- (* 3 (* a c)) b)) 
            (gen_markov_sequence lower upper b c (- (* 3 (* b c)) a)) ) ) )
    )
)

;;;; collapse (<val>)
;; PARAMS: Any natural number
;; RETURN: Any integer from 1 to 9
;; BEHAVIOR: Recursively sums each digit of the input until the sum is 
;; a single digit.
(defun collapse (val) (let ((sum 0))
    ;; BASE CASE - returns when parameter is single digit
    (if (< val 10) (return-from collapse val))

    ;; Takes the sum of each digit
    (loop while (< 0 val) do
        (setf sum (truncate (+ sum (mod val 10))))
        (setf val (truncate val 10))
    )

    ;; Recursive call
    (truncate (collapse (truncate sum)))
)) ;; END FUNCTION COLLAPSE

;;;; toRoman (<val>)
;; PARAMS: 'val' must be 0 ≤ val ≤ 9
;; RETURN: A string of the appropriate Roman numeral representation
;; BEHAVIOR: Implements a "greedy" algorithm to convert a single-digit number
;; into Roman numerals. 
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
(let ((LOWER_BOUND 0) (UPPER_BOUND 0)
      (sum         0) (col         0) )

    ;; Getting command line arguments
    (setf LOWER_BOUND (parse-integer (nth 1 *posix-argv*)))
    (setf UPPER_BOUND (parse-integer (nth 2 *posix-argv*)))
    (if (< UPPER_BOUND LOWER_BOUND) (rotatef LOWER_BOUND UPPER_BOUND)) ;; Swap

    ;; Calling functions and assigning data
    (setf sum (markov LOWER_BOUND UPPER_BOUND))
    (setf col (collapse sum))

    ;; Displaying output
    (format t "   Count: ~d~%" TRACK)
    (format t "     Sum: ~d~%" sum)
    (format t "Collapse: ~d~%" col)
    (format t "   Roman: ~a~%" (toRoman col))
    (if (= 0 (mod col 2))
        (format t "  --Hail Caesar!~%")
        (format t "  --et tu Brute!~%")
    )
    ;; UNCOMMENT TO DISPLAY ARRAY
    ;; (format t "Sequence: ~d~%" markovElements)
)