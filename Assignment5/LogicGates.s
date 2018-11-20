     area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
	 
SigmoidFunc PROC				  ;start of subroutine SigmoidFunc
	;VLDR.F32 S10, =-10  		  ;In e^x, S10 stores value of 'x'
	VMOV.F32 S11, #25 			  ;Number of terms 'n' in e^x series
	VMOV.F32 S12, #1  			  ;i : a pointer to count from 1 to n
	VMOV.F32 S13, #1  			  ;temp2 = 1  , a temporary variable to store intermdediate result
	VMOV.F32 S14, #1  			  ;sum
	VMOV.F32 S15, #1  			  ;'1'
Loop 
	 VCMP.F32 S11, S12            ;i proceeds from 1(S12) to n(S11) till S11 is greater than or equal to S12
	 VMRS.F32 APSR_nzcv,FPSCR     ;Transfer floating-point flags to the APSR flags
	 BLT stop;
	 VDIV.F32 S16, S10, S12       ;temp1=x/i , another temporary variable to store intermdediate result
	 VMUL.F32 S13, S13, S16       ;temp2=temp2*temp1; [Power and Factorial] Ex: x/1 * x/2 = x sq /2!
	 VADD.F32 S14, S14, S13       ;sum=sum+temp2 [Accumulation] The final answer can be seen in S14
	 VADD.F32 S12, S12, S15       ;i = i+ 1 [Incrementing]
	 B Loop; 
	 
stop
	 VADD.F32 S16,S15,S14         ; 1 + e^x
	 VDIV.F32 S17,S14,S16         ; e^x / 1 + e^x = Sigmoid Function
	 VMOV.F32 R0,S17              ; Save the result in R0 to print
	 
	 BX LR						  ;Jumps back to the instruction pointed by LR
	 ENDP						  ;End of subroutine



;Calculation of 'z' in the main function using inputs and weights and then calling the sigmoid function
__main  function		 
	 VLDR.F32 S20, =1			  ;X1 INPUT
	 VLDR.F32 S21, =0			  ;X2 INPUT
	 VLDR.F32 S22, =1			  ;X3 INPUT
	 
	 
	 ADR.W R1,SwitchCases		  ; R1 contains the address of Switchcases
	 MOV R2,#5					  ; R2 contains index of the case
	 TBB[R1,R2]					  
		   
LOGIC_AND	 VLDR.F32 S24 ,=-0.1			  ;W1 WEIGHT
			 VLDR.F32 S25 ,=0.2			 	  ;W2 WEIGHT
			 VLDR.F32 S26 ,=0.2			 	  ;W3 WEIGHT
			 VLDR.F32 S27 ,=-0.2		  	  ;BIAS
			 B Z_VAL

LOGIC_OR	 VLDR.F32 S24 ,=-0.1			  ;W1 WEIGHT
			 VLDR.F32 S25 ,=0.7			 	  ;W2 WEIGHT
			 VLDR.F32 S26 ,=0.7			 	  ;W3 WEIGHT
			 VLDR.F32 S27 ,=-0.1		  	  ;BIAS
			 B Z_VAL

LOGIC_NAND	 VLDR.F32 S24 ,=0.6			 	  ;W1 WEIGHT
			 VLDR.F32 S25 ,=-0.8			  ;W2 WEIGHT
			 VLDR.F32 S26 ,=-0.8			  ;W3 WEIGHT
			 VLDR.F32 S27 ,=0.3		  		  ;BIAS
			 B Z_VAL
			 
LOGIC_NOR	 VLDR.F32 S24 ,=0.5			 	  ;W1 WEIGHT
			 VLDR.F32 S25 ,=-0.7			  ;W2 WEIGHT
			 VLDR.F32 S26 ,=-0.7			  ;W3 WEIGHT
			 VLDR.F32 S27 ,=0.1		  		  ;BIAS
			 B Z_VAL
			 
LOGIC_XOR	 VLDR.F32 S24 ,=5			 	  ;W1 WEIGHT
			 VLDR.F32 S25 ,=-20				  ;W2 WEIGHT
			 VLDR.F32 S26 ,=-10				  ;W3 WEIGHT
			 VLDR.F32 S27 ,=-1		  		  ;BIAS
			 B Z_VAL

LOGIC_XNOR	 VLDR.F32 S24 ,=-5			 	  ;W1 WEIGHT
			 VLDR.F32 S25 ,=20				  ;W2 WEIGHT
			 VLDR.F32 S26 ,=10				  ;W3 WEIGHT
			 VLDR.F32 S27 ,=1		  		  ;BIAS
			 B Z_VAL
			 
LOGIC_NOT	 VLDR.F32 S24 ,=-0.7			  ;W1 WEIGHT
			 VLDR.F32 S25 ,=0				  ;W2 WEIGHT
			 VLDR.F32 S26 ,=0				  ;W3 WEIGHT
			 VLDR.F32 S27 ,=0.1		  		  ;BIAS
			 B Z_VAL
	 
Z_VAL		 VMUL.F32 S18,S20,S24		  ; X1 * W1
			 VMUL.F32 S19,S21,S25		  ; X2 * W2
			 VMUL.F32 S28,S22,S26		  ; X3 * W3	 
			 VADD.F32 S18,S18,S19		  ;(X1 * W1) + (X2 * W2)
			 VADD.F32 S19,S28,S27		  ;(X3 * W3) + (BIAS * 1)
			 VADD.F32 S10,S18,S19		  ;(X1 * W1) + (X2 * W2)+(X3 * W3) + (BIAS * 1)
			 BL SigmoidFunc				  ;Calls the subroutine SigmoidFunc 
										  ;and copies the address of next instruction in (LR)linking register R14
	 
SwitchCases				  DCB   0		  					;Offset of all cases
						  DCB   ((LOGIC_OR-LOGIC_AND)/2)
						  DCB   ((LOGIC_NAND-LOGIC_AND)/2)
						  DCB   ((LOGIC_NOR-LOGIC_AND)/2)
						  DCB   ((LOGIC_XOR-LOGIC_AND)/2)
						  DCB   ((LOGIC_XNOR-LOGIC_AND)/2)
						  DCB   ((LOGIC_NOT-LOGIC_AND)/2)
						  
     BL printMsg	 ; Refer to ARM Procedure calling standards.
fullstop   	 B  fullstop ; stop program	   
     endfunc
     end