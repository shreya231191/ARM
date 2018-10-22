    AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
		 MOV  R0, #0x40 ;load the the two numbers in registers
         MOV  R1, #0x20
		 
REPEAT	CMP R0 , R1
				IT EQ
				BEQ STOP ;Stop the loop once R0 and R1 become equal
					
				IT PL	; Repeat this logic until they are unequal
					SUBPL R0 , R0 , R1 	
					MOVPL R3,R0	;R3 stores the GCD
					SUBMI R1 , R1 , R0
					MOVMI R3,R1 ;R3 stores the GCD
				B REPEAT	
				
STOP B STOP  ; stop program
        endfunc
      end


	