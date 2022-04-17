*-----------------------------------------------------------
* Title      : X68000 Motarola Disassembler for CSS 422
* Written by : Jacob Ryse, Leanne Vu, Liam Morrison, Rachel Graham
* Date       : 4/16/2022
* Description: Disassembler for the X68000 Motarola CPU
*-----------------------------------------------------------

    ORG     $1000


START:
    
    
    MOVE.B  #9,D0
    TRAP    #15
    
    END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
