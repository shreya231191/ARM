     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
         MOV  R0, #0x10 ;load the the three numbers in registers
         MOV  R1, #0x20
		 MOV  R2, #0x30
		 
		 CMP  R0, R1
		 ITE  PL	
		 MOVPL R5,R0 ;store whichever is greater among R0,R1 in R5
		 MOVMI R5,R1
		 
		 CMP  R5,R2		 
		 ITE  PL
		 MOVPL  R3,R5 ;R0 or R1 is largest
		 MOVMI  R3,R2 ;R2 is largest
		
		 
stop B stop ; stop program
     ENDFUNC
     END