       IDENTIFICATION DIVISION.
       PROGRAM-ID. genmarkov IS RECURSIVE.
       AUTHOR. Caramel Macchiato
       DATE-WRITTEN. December 6, 2022

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       DATA DIVISION.
       LOCAL-STORAGE SECTION.
           01 Temp PIC 9(12) VALUE ZERO.

       LINKAGE SECTION.
           01 Low PIC 9(12) COMP-5.
           01 High PIC 9(12) COMP-5.
           01 M-Table.
               05 M-Value PIC 9(12) OCCURS 150 TIMES INDEXED BY I.

      *    Corresponds to each value of a given Markov triple. *  
           01 a PIC 9(12) COMP-5.
           01 b PIC 9(12) COMP-5.
           01 c PIC 9(12) COMP-5.
           
       PROCEDURE DIVISION USING Low, High, M-Table, a, b, c.
         
      *    Add to table if the c-value is a unique Markov number. *    
           IF c >= Low AND c <= High THEN  
               IF 3*a*b*c = a*a + b*b + c*c THEN 
      *    Index variable. *
                   SET I TO 1.
                   SEARCH M-Value 
                       AT END 
                           MOVE c TO M-Table
                       WHEN M-Value(I) = c 
                           CONTINUE. 
                          
      *    BASE CASE *
           IF c > High THEN
               EXIT PROGRAM.
       
      *    Tree traversal to jump into the given range. * 
           IF c < Low AND c <= 2 THEN  
               COMPUTE Temp = 3*a*c - b.
               CALL 'genmarkov' USING Low, High, M-Table, a, c, Temp.

           IF c < Low AND c > 2 THEN
               COMPUTE Temp = 3*a*c - b.
               CALL 'genmarkov' USING Low, High, M-Table, a, c, Temp.
               COMPUTE Temp = 3*b*c - a.
               CALL 'genmarkov' USING Low, High, M-Table, a, c, Temp.
               COMPUTE Temp = 3*a*b - c.
               CALL 'genmarkov' USING Low, High, M-Table, b, c, Temp.  

           IF c <= 2 THEN  
      *    Traverse to the top/next linear node in the tree. *
               CALL 'genmarkov' USING Low, High, M-Table, a, c, Temp.

      *    Traverse to the top and bottom subtrees. *
           CALL 'genmarkov' USING Low, High, M-Table, a, c, Temp.
           CALL 'genmarkov' USING Low, High, M-Table, a, c, Temp.
           CALL 'genmarkov' USING Low, High, M-Table, b, c, Temp.

       EXIT PROGRAM.
           