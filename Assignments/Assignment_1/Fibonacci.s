    AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
		 MOV  R0, #0x07 ;load the numbers in series to be displayed
		 
		MOV R1, #0x0    ;R5 is the register where the series will be displayed
		MOV R2, #0x01   ;Initialize the first 2 fibonacci series numbers into to R1 and R2 
		MOV R5, R1
		MOV R5, R2	    ;Display the first two numbers via R5
		SUB R0,R0,#0x02 ;Reduce the count in R0 by 2, since 2 numbers are already displayed
		
REPEAT		CMP R0, #0x0;Run the loop till count in R0 becomes zero
		
		IT EQ 
		BEQ STOP
		
		IT NE
		MOVNE R4,R2
		ADDNE R2,R1,R2  ;Add the previous 2 numbers
		MOVNE R1,R4	    ;to get the next number in the series
		MOVNE R5,R2     ;display the new number of the series
		SUBNE R0,#0x01  ;update the count in R0 after every number in series gets displayed
		BNE REPEAT
		
		 
STOP B STOP  ; stop program
        endfunc
      end

