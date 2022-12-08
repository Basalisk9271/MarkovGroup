       IDENTIFICATION DIVISION.
       PROGRAM-ID. genmarkov IS RECURSIVE.
       AUTHOR. Caramel Macchiato
       DATE-WRITTEN. December 6, 2022

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       DATA DIVISION.
       LOCAL-STORAGE SECTION.
           01 Temp PIC 9(12) VALUE ZERO.
           01 Temp1 PIC 9(12) VALUE ZERO.
           01 Temp2 PIC 9(12) VALUE ZERO.
           01 Temp3 PIC 9(12) VALUE ZERO.
           01 Summ usage is binary-long unsigned value 0.
           01 Summ1 usage is binary-long unsigned value 0.
           01 Summ2 usage is binary-long unsigned value 0.
           01 Summ3 usage is binary-long unsigned value 0.
           01 RunSum usage is binary-long unsigned value 0.



       LINKAGE SECTION.
           01 Low PIC 9(12) COMP-5.
           01 High PIC 9(12) COMP-5.
           01 M-Table.
               05 M-Value binary-long unsigned OCCURS 150 TIMES
                 INDEXED BY I.

      *    Corresponds to each value of a given Markov triple. *  
           01 a PIC 9(12) COMP-5.
           01 b PIC 9(12) COMP-5.
           01 cval PIC 9(12) COMP-5.
      *    01 summ usage is binary-long unsigned value 0.
           
       PROCEDURE DIVISION USING Low, High, M-Table, a, b, cval.
         
                                display "cval "cval.
      *    Add to table if the c-value is a unique Markov number. *    
           IF cval >= Low AND cval <= High THEN  
               IF 3*a*b*cval = a*a + b*b + cval*cval THEN 
      *    Index variable. *
                   SET I TO 1.
                   SEARCH M-Value 
                       AT END 
                           SET M-Value(I) TO cval
                           compute summ = summ + cval
                                display "Currentsum: "summ
                       WHEN M-Value(I) = cval 
                           CONTINUE. 
                          
      *    BASE CASE *
           IF cval > High THEN
               EXIT PROGRAM returning 0.
       
      *    Tree traversal to jump into the given range. * 
           IF cval < Low THEN
              if cval <= 2 THEN  
                COMPUTE Temp = 3*a*cval - b
                CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp
                returning summ
                EXIT PROGRAM RETURNING SUMM
           
              ELSE
               COMPUTE Temp1 = 3*a*cval - b
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp1
                returning summ1
               COMPUTE Temp2 = 3*b*cval - a
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp2
                returning summ2
               COMPUTE Temp3 = 3*a*b - cval
               CALL 'genmarkov' USING Low, High, M-Table, b, cval, Temp3
                returning summ3
               COMPUTE SUMM = summ1 + summ2 + summ3
                EXIT PROGRAM RETURNING SUMM
                end-if
        end-if.


           IF cval <= 2 then 
      *    Traverse to the top/next linear node in the tree. *
                COMPUTE Temp = 3*a*cval - b
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp
                returning summ
                COMPUTE summ = summ + cval
                EXIT PROGRAM RETURNING SUMM

           ELSE
      *    Traverse to the top and bottom subtrees. *
               COMPUTE Temp1 = 3*a*cval - b
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp1
                returning summ1
               COMPUTE Temp2 = 3*b*cval - a
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp2
                returning summ2
               COMPUTE Temp3 = 3*a*b - cval
               CALL 'genmarkov' USING Low, High, M-Table, b, cval, Temp3
                returning summ3
                COMPUTE summ = summ1 + summ2 + summ3 + cval
                EXIT PROGRAM RETURNING SUMM

          end-if.
                

       EXIT PROGRAM.
           
