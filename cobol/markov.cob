       identification division.
       program-id.
       markov.
       author.
           Caramel Macchiato
       date-written.
           December 4, 2022.

       environment division.
       input-output section.

       data division.        
       working-storage section.
           01 lower pic 9(2) value 10.
           01 upper pic 9(2) value 50.
           01 cmdline pic x(50).
           01 arg1 pic x(50).
           01 arg2 pic x(50).
      *     01 summ usage is binary-double unsigned.
      *GenMarkov Vars
           01 a PIC 9(12) COMP-5 value 1.
           01 b PIC 9(12) COMP-5 value 1.
           01 cval PIC 9(12) COMP-5 value 1.
           01 M-Table.
               05 M-Value PIC 9(12) OCCURS 150 TIMES INDEXED BY I.
           01 summ usage is binary-long unsigned.
      *End GenMarkov Vars

      *    Collapse Vars 
      *     01 num usage is binary-long unsigned value 769.
           01 coll pic 9(1) value 0.
      *    End Collapse Vars
           
      


       procedure division.

           accept cmdline from command-line.
           display cmdline.
           move function trim(cmdline) to cmdline.
           display cmdline.

           unstring cmdline delimited by space into arg1 arg2.
           display arg1.
           display arg2.


           compute lower = function numval(arg1).
           compute upper = function numval(arg2).
           display "Lower: " lower.
           display "Upper: " upper.


      *cringe-para.
      *     display lower. 
      *    add 1 to lower.
           
      * perform cringe-para until lower>upper. 

      * GenMarkov
        genmarkov-para.
           call 'genmarkov' using lower, upper, M-Table, a, b, cval
                returning summ.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 7
         DISPLAY M-Value(I)
        END-PERFORM.
      * End GenMarkov


        display summ.

      * Collapse Call
       collaps-para.
           call 'collapse' using value summ returning coll
           display "Collapse: " coll.
      * End Collapse Call

       stop run.

