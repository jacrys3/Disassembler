*-----------------------------------------------------------
* Title      : X68000 Motarola Disassembler for CSS 422
* Written by : Jacob Ryse, Leanne Vu, Liam Morrison, Rachel Graham
* Date       : 4/16/2022
* Description: Disassembler for the X68000 Motarola CPU
*-----------------------------------------------------------

    ORG     $1000

**************** START ***************************

START:
    
    LEA     WMSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     ENTERMSG1,A1
    MOVE.B  #14,D0
    TRAP    #15
    
 
    *First number
    MOVE.B  #2,D0
    TRAP    #15
    
    MOVE.L  A1,A2
    
    LEA     ENTERMSG2,A1
    MOVE.B  #14,D0
    TRAP    #15

    *Second number
    MOVE.B  #2,D0
    TRAP    #15

    MOVE.L  A1,A3

    *Set A1 to A2 for iteration
    MOVE.L  A2,A1

    CLR D3
    
    JSR ConvertHex
    
    MOVE.L  D3,D2
    
    CLR D3
    
    JSR ConvertHex
    

****************** Main LOOP *************************

MainLoop:
    
  

  
END:
    MOVE.B  #9,D0
    TRAP    #15
  

************** CONVERT INPUT TO HEX ******************

ConvertHex:
    * D2 and D3 will be used to store the new values for
    * A2 and A3 respectivly 
    
    CMP.B   #$30,(A1)
    BEQ     zero
    
    CMP.B   #$31,(A1)
    BEQ     one
    
    CMP.B   #$32,(A1)
    BEQ     two
    
    CMP.B   #$33,(A1)
    BEQ     three
    
    CMP.B   #$34,(A1)
    BEQ     four
    
    CMP.B   #$35,(A1)
    BEQ     five
    
    CMP.B   #$36,(A1)
    BEQ     six
    
    CMP.B   #$37,(A1)
    BEQ     seven
    
    CMP.B   #$38,(A1)
    BEQ     eight
    
    CMP.B   #$39,(A1)
    BEQ     nine
    
    CMP.B   #$41,(A1)
    BEQ     a

    CMP.B   #$42,(A1)
    BEQ     b

    CMP.B   #$43,(A1)
    BEQ     c

    CMP.B   #$44,(A1)
    BEQ     d
    
    CMP.B   #$45,(A1)
    BEQ     e

    CMP.B   #$46,(A1)
    BEQ     f   
    
    BRA     invalid
   
zero:

    ASL.L   #4,D3
    ADDI.L  #$00,D3
    ADDQ    #1,A1
    BRA     ConvertHex

one:
    ASL.L   #4,D3
    ADDI.L  #$01,D3
    ADDQ    #1,A1
    BRA     ConvertHex

two:
    ASL.L   #4,D3
    ADDI.L  #$02,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

three:
    ASL.L   #4,D3
    ADDI.L  #$03,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

four:
    ASL.L   #4,D3
    ADDI.L  #$04,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

five:
    ASL.L   #4,D3
    ADDI.L  #$05,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

six:
    ASL.L   #4,D3
    ADDI.L  #$06,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

seven:
    ASL.L   #4,D3
    ADDI.L  #$07,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

eight:
    ASL.L   #4,D3
    ADDI.L  #$08,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

nine:
    ASL.L   #4,D3
    ADDI.L  #$09,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

a:
    ASL.L   #4,D3
    ADDI.L  #$0A,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

b:
    ASL.L   #4,D3
    ADDI.L  #$0B,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

c:
    ASL.L   #4,D3
    ADDI.L  #$0C,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

d:
    ASL.L   #4,D3
    ADDI.L  #$0D,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

e:
    ASL.L   #4,D3
    ADDI.L  #$0E,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex

f:
    ASL.L   #4,D3
    ADDI.L  #$0F,D3
    ADDQ    #1,A1
    
    BRA     ConvertHex
    
invalid:
    
    JMP     END



******************* CONSTANTS ************************

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
