*-----------------------------------------------------------
* Title      : X68000 Motarola Disassembler for CSS 422
* Written by : Jacob Ryse, Leanne Vu, Liam Morrison, Rachel Graham
* Date       : 4/16/2022
* Description: Disassembler for the X68000 Motarola CPU
*-----------------------------------------------------------

    ORG     $1000


START:
    
    LEA     WMSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     ENTERMSG1,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR (A1)
    *First number
    MOVE.B  #2,D0
    TRAP    #15

    MOVEA.L  A1,A2
    
    
    LEA     ENTERMSG2,A1
    MOVE.B  #14,D0
    TRAP    #15

    CLR (A1)
    *Second number
    MOVE.B  #2,D0
    TRAP    #15

    MOVE.L  A1,A3

    MOVE.L D2,SP


    BRA ReadMemory
    


ReadMemory:
    MOVE.L  (SP)+,D1

    MOVE.B  #3,D0
    TRAP    #15
    
    CMP.L   SP,D3
    BLE END
    
    BRA ReadMemory
    
END:
    MOVE.B  #9,D0
    TRAP    #15
  

ConvertHex:
    



CR  EQU $0D
LF  EQU $0A

WMSG         DC.B    'Welcome to Group 3s X68000 Dissassembler!',CR,LF
             DC.B    'First make sure to load your program into memory',CR,LF
             DC.B    'Next enter two memory addresses, the start and end of',CR,LF
             DC.B    'your program',CR,LF,0
SPACE        DC.B    '',CR,LF,0
ENTERMSG1    DC.B   'Enter starting address: ',0
ENTERMSG2    DC.B   'Enter ending address: ',0 
  
    END     START





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
