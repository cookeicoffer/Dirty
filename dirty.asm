DPTR_L        EQU        30H
        ORG        0H
        MOV        SP,#60H
        JMP        START
        
        ORG        30H
START:
        MOV        DPTR_L,#40H
        MOV        A,#3FH
        CALL        WRITE_IR
        MOV        A,#0C0H
        CALL        WRITE_IR
        CALL        CLRSCR
        MOV        R0,#21H
        MOV        R1,#2
        MOV        DPTR,#WORD2
        CALL        SHOW_24X24
        CALL	DELAY
        CALL	REPEAT 
        JMP        $
SHOW_24X24:
        MOV        A,R0
        ORL        A,#40H
        CALL        WRITE_IR
        MOV        A,R1
        ORL        A,#0B8H
        CALL        WRITE_IR
        MOV        R2,#24
show_1:
        MOV        A,#0
        MOVC        A,@A+DPTR
        CALL        WRITE_DR
        INC        DPTR
        DJNZ        R2,show_1
        INC        R1
        MOV        A,R1
        ORL        A,#0B8H
        CALL        WRITE_IR
        MOV        A,R0
        ORL        A,#40H
        CALL        WRITE_IR
        MOV        R2,#24
show_2:
        MOV        A,#0
        MOVC        A,@A+DPTR
        CALL        WRITE_DR
        INC        DPTR
        DJNZ        R2,show_2
        INC        R1
        MOV        A,R1
        ORL        A,#0B8H
        CALL        WRITE_IR
        MOV        A,R0
        ORL        A,#40H
        CALL        WRITE_IR
        MOV        R2,#24
show_3:
        MOV        A,#0
        MOVC        A,@A+DPTR
        CALL        WRITE_DR
        INC        DPTR
        DJNZ        R2,show_3
        RET
CLRSCR:
        MOV        R0,#0
set_y:        MOV        A,#0B8H
        ORL        A,R0
        CALL        WRITE_IR
        MOV        A,#40H
        CALL        WRITE_IR
        MOV        R1,#64H
clr_row:MOV        A,#0H
        CALL        WRITE_DR
        DJNZ        R1,clr_row
        INC        R0
        CJNE        R0,#8,set_y
        RET
CHECK_BUSY:
        PUSH        ACC
        MOV        DPH,#80H
        MOV        DPL,DPTR_L
BUSY:        MOVX        A,@DPTR
        JB        ACC.7,BUSY
        POP        ACC
        RET
WRITE_IR:
        PUSH        DPL
        PUSH        DPH
        CALL        CHECK_BUSY
        MOV        DPH,#80H
        MOV        DPL,DPTR_l
        MOVX        @DPTR,A
        POP        DPH
        POP        DPL
        RET
WRITE_DR:
        PUSH        DPL
        PUSH        DPH
        CALL        CHECK_BUSY
        MOV        DPH,#80H
        MOV        DPL,DPTR_L
        INC        DPL
        MOVX        @DPTR,A
        POP        DPH
        POP        DPL
        RET


REPEAT:	
	MOV        DPTR_L,#40H
        MOV        A,#3FH
        CALL        WRITE_IR
        MOV        A,#0C0H
        CALL        WRITE_IR
        CALL        CLRSCR
        MOV        R0,#21H
        MOV        R1,#2
        MOV        DPTR,#WORD1
        CALL        SHOW_24X24
        RET

DELAY:	MOV	R7,#20H
D1:	MOV	R6,#0
	DJNZ	R6,$
	DJNZ	R7,D1
	RET


WORD1:
        DB        10H,10H,10H,10H,30H,50H,90H,10H
        DB        10H,11H,12H,14H,18H,10H,10H,10H
        DB        90H,50H,30H,10H,10H,10H,10H,10H
        
        DB        08H,08H,08H,08H,08H,08H,08H,09H
        DB        0AH,0CH,08H,08H,08H,0CH,0AH,09H
        DB        08H,08H,08H,08H,08H,08H,08H,08H
        
                
        DB        00H,00H,00H,00H,0FFH,0FFH,08H,08H
        DB        08H,08H,08H,08H,08H,08H,08H,08H
        DB        08H,08H,0FFH,0FFH,00H,00H,00H,00H
                

WORD2:
        DB        00H,0CH,12H,20H,40H,40H,80H,80H
        DB        80H,80H,40H,40H,20H,40H,40H,80H
        DB        80H,80H,80H,40H,40H,20H,0CH,00H

        DB        00H,00H,00H,00H,00H,00H,08H,14H
        DB        0F4H,02H,03H,01H,01H,03H,02H,0F4H
        DB        14H,08H,00H,00H,00H,00H,00H,00H
        
        DB        00H,00H,1CH,22H,42H,42H,42H,43H
        DB        40H,20H,10,10H,10H,20H,40H,43H
        DB        42H,42H,42H,22H,1CH,00H,00H,00H
        
        
        END

	
