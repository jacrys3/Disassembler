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
    
    CLR D2
    CLR D3
    JSR decode
    
    
    MOVE.L  D3,D4
    
    LEA     ENTERMSG2,A1
    MOVE.B  #14,D0
    TRAP    #15

    *Second number
    MOVE.B  #2,D0
    TRAP    #15
    
    CLR D2
    CLR D3
    JSR decode
    
    CLR D5
    MOVE.L  D3,D5
    MOVE.L  D4,D3
    CLR D4
    
    MOVE.L  D5,D4
    
    CLR D5
    CLR D2
    
    MOVE.L  D3,A5
    BRA MainLoop
    

****************** Main LOOP *************************

MainLoop:
    * put instruction into D6
    * print out address first, then print rest out in opcode section...
    MOVE.W  (A5)+,D6
    JSR opcodes
    
    LEA SPACE,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CMPA    D4,A5
    BLE     MainLoop
    
    BRA END
  
END:
    MOVE.B  #9,D0
    TRAP    #15
  

************** CONVERT INPUT TO HEX ******************

decode:

    CMP.B   D2,D1
    BEQ     return 

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
   
return:
    RTS
   
zero:

    ASL.L   #4,D3
    ADDI.L  #$00,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

one:
    ASL.L   #4,D3
    ADDI.L  #$01,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

two:
    ASL.L   #4,D3
    ADDI.L  #$02,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    
    BRA     decode

three:
    ASL.L   #4,D3
    ADDI.L  #$03,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    
    BRA     decode

four:
    ASL.L   #4,D3
    ADDI.L  #$04,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    
    BRA     decode

five:
    ASL.L   #4,D3
    ADDI.L  #$05,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

six:
    ASL.L   #4,D3
    ADDI.L  #$06,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

seven:
    ASL.L   #4,D3
    ADDI.L  #$07,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

eight:
    ASL.L   #4,D3
    ADDI.L  #$08,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

nine:
    ASL.L   #4,D3
    ADDI.L  #$09,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

a:
    ASL.L   #4,D3
    ADDI.L  #$0A,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

b:
    ASL.L   #4,D3
    ADDI.L  #$0B,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

c:
    ASL.L   #4,D3
    ADDI.L  #$0C,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

d:
    ASL.L   #4,D3
    ADDI.L  #$0D,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

e:
    ASL.L   #4,D3
    ADDI.L  #$0E,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode

f:
    ASL.L   #4,D3
    ADDI.L  #$0F,D3
    ADDQ    #1,A1
    ADDQ    #1,D2
    BRA     decode
        
invalid:
    
    JMP     END

******************** OPCODES *************************

* format as -memory location-  -opcode-  -operand-
* invalids displayed as  1000  DATA  -uncoded hex-
* each opcode should branch to the next if it is not that specific opcode

opcodes:
*-----get instruction from memory, put in D6 (NEED TO DO THIS BEFORE EVERY AND)-----

*------Liam-------

*------NOP-------
nop:
    CLR D5
    MOVE.W  #$FFFFFFFF,D5
    AND.W  D6,D5
    CMP.W   #%0100111001110001,D5
    BNE movea
    
    LEA msgnop,A1
    MOVE.W  #14,D0
    TRAP    #15
    
    RTS
  
*------MOVEA-------
movea:
    CLR D5
    MOVE.W  #%1100000111000000,D5
    AND.W  D6,D5
    CMP.W   #%0000000001000000,D5
    BNE move

    LEA msgmovea,A1
    MOVE.B  #14,D0
    TRAP    #15  

    JSR movesize  
    
    JSR ea

    RTS
*------MOVE-------
move:
    CLR D5
    MOVE.W  #%1100000000000000,D5
    AND.W  D6,D5
    CMP.W   #%0000000000000000,D5
    BNE moveq
    
    LEA msgmove,A1
    MOVE.B  #14,D0
    TRAP    #15 
   
    JSR movesize
    
    JSR ea
   
    RTS
*------MOVEQ-------
moveq:
    CLR D5
    MOVE.W  #%1111000100000000,D5
    AND.W  D6,D5
    CMP.W   #%0111000000000000,D5
    BNE movem
    
    LEA msgmoveq,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR ea
    
    RTS
*------MOVEM-------
movem: ** NOT COMPLETE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    CLR D5
    MOVE.W  #%1111101110000000,D5
    AND.W  D6,D5
    CMP.W   #%0100100010000000,D5
    BNE add

    LEA msgmovem,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR movemsize
    
    JSR ea *gonna have to do something more than this
    
    RTS
*------ADD-------
add:
    CLR D5
    MOVE.W  #%1111000000000000,D5
    AND.W  D6,D5
    CMP.W   #%1101000000000000,D5
    BNE addq
    
    * If ADDA then go there
    CLR D5
    MOVE.W  #%1111000111000000,D5
    AND.W  D6,D5
    CMP.W   #%1101000011000000,D5
    BEQ adda
    CMP.W   #%1101000111000000,D5
    BEQ adda

    * Must be ADD
    LEA msgadd,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR addsize
    
    JSR ea
    
    RTS
*------ADDA-------
adda:

    LEA msgadda,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR addasize

    JSR ea

    RTS

*------ADDQ-------
addq:
    CLR D5
    MOVE.W  #%1111000100000000,D5
    AND.W  D6,D5
    CMP.W   #%0101000000000000,D5
    BNE sub
    
    LEA msgaddq,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR ea
    RTS

*--- Sizes ---
movesize:
    MOVE.W  #%0011000000000000,D5
    AND.W   D6,D5
    
    CMP.W   #%0001000000000000,D5
    BEQ printbyte
    CMP.W   #%0011000000000000,D5 
    BEQ printword
    
    BRA printlong 
    
movemsize:
    MOVE.W  #%0000000001000000,D5
    AND.W   D6,D5
    
    CMP.W   #%0000000001000000,D5 
    BEQ printword
    
    BRA printlong
    
addsize:
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    
    CMP.W   #%0000000000000000,D5
    BEQ printbyte
    
    CMP.W   #%0000000100000000,D5
    BEQ printbyte
    
    CMP.W   #%0000000001000000,D5 
    BEQ printword
    
    CMP.W   #%0000000101000000,D5 
    BEQ printword
    
    BRA printlong 

addasize:
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    
    CMP.W   #%0000000011000000,D5 
    BEQ printword
    
    BRA printlong 
    
*------- Printing of sections --------
printbyte:

    LEA msgbyte,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

printword:
    LEA msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS
printlong
    LEA msglong,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS    
*----------------END Liam-----------------------    

*------SUB-------
sub:

*------LEA-------
lea:
    
*------AND-------
and:

*------OR-------
or:

*------NOT-------
not:



*-----JACOB------

*------LSL------- (pg 217)

* format (register shift) LSL #<data>,Dy or LSL Dx,Dy
* |1110|count/register|1|size|i/r|01|register|
lslregshift:
    MOVE.W  #%1111000100011000,D5   *move binary to AND into D5
    AND.W   D6,D5
    CMP     #%1110000100001000,D5   *compare if is correct opcode
    BNE     lslmemshift             *if not equal branch to next opcode
    
    * check size


* format (memory shift) LSL <ea>
* |1110001111|EA mode|EA register|
lslmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110001111000000,D5
    BNE     lsrregshift
    

*------LSR------- (pg 217)

* format (register shift) LSR #<data>,Dy or LSR Dx,Dy
* |1110|count/register|0|size|i/r|01|register|
lsrregshift:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000000001000,D5
    BNE     lsrmemshift

* format (memory shift) LSR <ea>
* |1110001011|EA mode|EA register|
lsrmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110001011000000,D5
    BNE     aslregshift

*------ASL------- (pg 125)

* format (register shift) ASL #<data>,Dy or ASL Dx,Dy
* |1110|count/register|1|size|i/r|00|register|
aslregshift:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000100000000,D5
    BNE     aslmemshift

* format (memory shift) ASL <ea>
* |1110000111|EA mode|EA register|
aslmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110000111000000,D5
    BNE     asrregshift

*------ASR------- (pg 125)

* format (register shift) ASR #<data>,Dy or ASR Dx,Dy
* |1110|count/register|0|size|i/r|00|register|
asrregshift:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000000000000,D5
    BNE     asrmemshift

* format (memory shift) ASR <ea>
* |1110000011|EA mode|EA register|
asrmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110000011000000,D5
    BNE     rolregrot

*------ROL------- (pg 264)

* format (register rotate) ROL #<data>,Dy or ROL Dx,Dy
* |1110|count/register|1|size|i/r|11|register|
rolregrot:
    MOVE.W  #%1110000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000100011000,D5
    BNE     rolmemrot

* format (memory rotate) ROL <ea>
* |1110011111|EA mode|EA register|
rolmemrot:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110011111000000,D5
    BNE     rorregrot

*------ROR------- (pg 264)

* format (register rotate) ROR #<data>,Dy or ROR Dx,Dy
* |1110|count/register|0|size|i/r|11|register|
rorregrot:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000000011000,D5
    BNE     rormemrot

* format (memory rotate) ROR <ea>
* |1110011011|EA mode|EA register|
rormemrot:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110011011000000,D5
    *BNE     BGT

*------RACHEL-----

*------BGT-------


*------BLE-------


*------BEQ-------


*------JSR-------


*------RTS-------


*------BRA-------



**************** EFFECTIVE ADDRESSING ********************

ea:
    RTS

* decoding individual EA's

*------Liam-------

*----DATA REGISTER DIRECT---
eadrd:
    LEA msgdatar

*----IMEDIATE DATA------
eaid:




*----LEANNE-----

*----ADDRESS REGISTER DIRECT---


*----ADDRESS REGISTER INDIRECT----





*-----JACOB-----

*----ADDRESS REGISTER INDIRECT WITH POST INCREMENTING----


*----ADDRESS REGISTER INDIRECT WITH PRE INCREMENTING----





*----RACHEL-----

*----ABSOLUTE LONG ADDRESS----


*----ABSOLUTE WORD ADDRESS----


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

msgmove      DC.B   'MOVE',0
msgmovea     DC.B   'MOVEA',0
msgmoveq     DC.B   'MOVEQ',0
msgmovem     DC.B   'MOVEM',0
msgadd       DC.B   'ADD',0
msgadda      DC.B   'ADDA',0
msgaddq      DC.B   'ADDQ',0
msgnop       DC.B   'NOP',0

msgbyte      DC.B   '.B',0
msgword      DC.B   '.W',0
msglong      DC.B   '.L',0

msgdatar     DC.B   'D',0
msgim        DC.B   '#',0
msgaddrr     DC.B   'A',0


  
    END     START



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
