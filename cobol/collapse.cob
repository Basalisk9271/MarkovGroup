       identification division.
       program-id.
       collapse is recursive.
       author.
           Caramel Macchiato
       date-written.
           December 5, 2022.
           
       environment division.
       input-output section.
       data division.
       local-storage section.
           01 i usage is binary-long unsigned.
           01 Summ usage is binary-long unsigned value 0.

       linkage section.
           01 Num usage is binary-long unsigned.
           
      * passed by value     
       procedure division using value Num.

           if Num < 10 then
               exit program returning Num.

           compute i = Num.

       loop-para.
           
           compute Summ = Summ + function mod (i 10).
           compute i = i / 10.

       perform loop-para until i <= 0. 
           
           call 'collapse' using value Summ returning Num.

       exit program.
