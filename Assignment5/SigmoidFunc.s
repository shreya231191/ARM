     area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
	 
SigmoidFunc PROC				  ;start of subroutine SigmoidFunc
	VLDR.F32 S10, =-5  		  ;In e^x, S10 stores value of 'x'
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

			 BL SigmoidFunc				  ;Calls the subroutine SigmoidFunc 
										  ;and copies the address of next instruction in (LR)linking register R14
	 

						  
     BL printMsg	 ; Refer to ARM Procedure calling standards.
fullstop   	 B  fullstop ; stop program	   
     endfunc
     end