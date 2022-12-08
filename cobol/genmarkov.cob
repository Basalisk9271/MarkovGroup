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
           01 cval PIC 9(12) COMP-5.
           
       PROCEDURE DIVISION USING Low, High, M-Table, a, b, cval.
         
      *    Add to table if the c-value is a unique Markov number. *    
           IF cval >= Low AND cval <= High THEN  
               IF 3*a*b*cval = a*a + b*b + cval*cval THEN 
      *    Index variable. *
                   SET I TO 1.
                   SEARCH M-Value 
                       AT END 
                           MOVE cval TO M-Table
                       WHEN M-Value(I) = cval 
                           CONTINUE. 
                          
      *    BASE CASE *
           IF cval > High THEN
               EXIT PROGRAM.
       
      *    Tree traversal to jump into the given range. * 
           IF cval < Low AND cval <= 2 THEN  
               COMPUTE Temp = 3*a*cval - b.
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp.

           IF cval < Low AND cval > 2 THEN
               COMPUTE Temp = 3*a*cval - b.
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp.
               COMPUTE Temp = 3*b*cval - a.
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp.
               COMPUTE Temp = 3*a*b - cval.
               CALL 'genmarkov' USING Low, High, M-Table, b, cval, Temp.

           IF cval <= 2 THEN  
      *    Traverse to the top/next linear node in the tree. *
               CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp.

      *    Traverse to the top and bottom subtrees. *
           CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp.
           CALL 'genmarkov' USING Low, High, M-Table, a, cval, Temp.
           CALL 'genmarkov' USING Low, High, M-Table, b, cval, Temp.

       EXIT PROGRAM.
           
