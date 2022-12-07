       IDENTIFICATION DIVISION.
       PROGRAM-ID. 
       TO-ROMAN.
   
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01  INPUT-NUMBER PIC 9.
       01  ROMAN-NUMERAL PIC X(10).
       
       PROCEDURE DIVISION.
       
       BEGIN.
       
       DISPLAY "Enter a number below 10: "
       
       ACCEPT INPUT-NUMBER
       
    * turning the number into roman numerals
      if INPUT-NUMBER = 0
          MOVE "N" TO ROMAN-NUMERAL
      end-if
       if INPUT-NUMBER = 1
          MOVE "I" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 2
          MOVE "II" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 3
          MOVE "III" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 4
          MOVE "IV" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 5
          MOVE "V" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 6
          MOVE "VI" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 7
          MOVE "VII" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 8
          MOVE "VIII" TO ROMAN-NUMERAL
       end-if
       if INPUT-NUMBER = 9
          MOVE "IX" TO ROMAN-NUMERAL
       end-if

       DISPLAY "The Roman numeral is " ROMAN-NUMERAL
       
       STOP RUN.
       
       END PROGRAM TO-ROMAN.

       
       