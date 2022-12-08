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
           01 lower pic 9(10) value 10.
           01 upper pic 9(10) value 50.
           01 cmdline pic x(50).
           01 arg1 pic x(50).
           01 arg2 pic x(50).

      *MakeMarkov Vars
           01 a usage is binary-long unsigned value 1.
           01 b usage is binary-long unsigned value 1.
           01 cval usage is binary-long unsigned value 1.
           01 M-Table.
               05 M-Value PIC 9(12) OCCURS 150 TIMES INDEXED BY I.
           01 Table-Search PIC 9(12).
           01 IndexNum usage is index value 1.
           01 summ usage is binary-long unsigned.
      *End GenMarkov Vars

      *    Collapse Vars 
           01 coll pic 9(1) value 0.
      *    End Collapse Vars
           
      * Formatting Variables 
           01 sumP pic z(9)9.
           01 countP pic z(9)9. 
      

       procedure division.

           accept cmdline from command-line.
           move function trim(cmdline) to cmdline.

           unstring cmdline delimited by space into arg1 arg2.

      * convert to numeric values
           compute lower = function numval(arg1).
           compute upper = function numval(arg2).
      
      *Make Markov Sequence
       makemarkov-para.
        
        PERFORM outer-para varying a from lower by 1 until a > upper.
        outer-para.  
            PERFORM middle-para varying b from 0 by 1 until b > upper.
        middle-para.
         
        PERFORM inner-para varying cval from 0 by 1 until cval > upper.

        inner-para.
                        IF 3*a*b*cval = a*a + b*b + cval*cval THEN
                        SET I TO 1
                         SEARCH M-Value
                           AT END
                             SET M-Value(IndexNum) TO a
                             compute IndexNum = IndexNum + 1
                             compute summ = summ + a
                             
                              
                           WHEN M-Value(I) = a
                              CONTINUE
                        END-IF.                

      *End Make Markov Sequence
        
        

      * Collapse Call
            collaps-para.
                COMPUTE IndexNum = IndexNum - 1 
                MOVE IndexNum TO countP
                display "Count: " countP
             MOVE summ TO sumP
        display "Sum: "sumP
        
            call 'collapse' using value summ
                returning coll
                display "Collapse: " coll.
      * End Collapse Call
      *
      * Conversion to Roman Numeral
        DISPLAY "Roman: " WITH NO ADVANCING.

       if coll = 1
          DISPLAY "I"
       end-if.
       if coll = 2
          DISPLAY"II"
       end-if.
       if coll = 3
          DISPLAY"III"
       end-if.
       if coll = 4
          DISPLAY"IV"
       end-if.
       if coll = 5
          DISPLAY"V"
       end-if.
       if coll = 6
          DISPLAY"VI"
       end-if.
       if coll = 7
          DISPLAY"VII"
       end-if.
       if coll = 8
          DISPLAY"VIII"
       end-if.
       if coll = 9
          DISPLAY "IX"
       end-if.
 
       if function mod (coll 2) = 0
                DISPLAY "--Hail Caesar!"
       else
                DISPLAY "--et tu Brute!"
       end-if.
      

       stop run.

