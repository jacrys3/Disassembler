    ORG $4000
    
START:
    ADD.B D2,D3
    ADDA.W A3,A4
    ADD.B  D1,D2
    MOVE.L  D3,D4
    MOVEQ   #4,D3
    ADDQ    #3,D3
    MOVEM.L   (A2)+,D1-D2
    

    END START





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
