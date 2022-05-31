*-----------------------------------------------------------
* Title      : X68000 Motarola Disassembler for CSS 422
* Written by : Jacob Ryse, Liam Morrison, Rachel Graham
* Date       : 4/16/2022
* Description: Disassembler for the X68000 Motarola CPU
*-----------------------------------------------------------

    ORG     $1000

**************** START ***************************
START:
    
    LEA     WMSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
ask:
    
    CLR.L D1
    CLR.L D2
    CLR.L D3
    CLR.L D4
    CLR.L D5
    CLR.L D6
    CLR.L D7

    LEA msgask,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1
    MOVE.B  #5,D0
    TRAP    #15
    
    CMP.B   #$79,D1
    BNE     END
    
    CLR.L D1
    
    LEA     SPACE,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgenter1,A1
    MOVE.B  #14,D0
    TRAP    #15  

    LEA (A2),A1

    *First number
    MOVE.B  #2,D0
    TRAP    #15
    
    
    CLR.L D2
    CLR.L D3
    JSR decode
    
    
    MOVE.L  D3,D4
    
    LEA     msgenter2,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA (A2),A1
    
    *Second number
    MOVE.B  #2,D0
    TRAP    #15
    
    CLR.L D2
    CLR.L D3
    JSR decode
    
    CLR.L D5
    MOVE.L  D3,D5
    MOVE.L  D4,D3
    CLR.L D4
    
    MOVE.L  D5,D4
    
    CLR.L D5
    CLR.L D2
    
    MOVE.L  D3,A5

    MOVE.B #0,counter

    BRA MainLoop


****************** Main LOOP *************************

MainLoop:
    * put instruction into D6
    * print out address first, then print rest out in opcode section...
    
    CLR.L D1

    MOVE.L  A5,D1
    CLR.L D2
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15
    
    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    MOVE.W  (A5)+,D6
    JSR opcodes
    
    LEA     SPACE,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1 
    MOVE.B  counter,D1
    ADDQ    #1,D1
    MOVE.B  D1,counter

    * Wait for next user input check
    CMP.B   #%00011100,counter
    BEQ     enterwait

    CMP.L   D4,A5
    BLE     MainLoop
   
    BRA ask
  
END:
    MOVE.B  #9,D0
    TRAP    #15
  

enterwait:

    MOVE.B #0,counter
    LEA  msgenter,A1
    TRAP    #15

    MOVE.B  #5,D0
    TRAP    #15

    CMP.B   #$0D,D1
    BEQ     MainLoop 

    BRA     enterwait

************** CONVERT INPUT TO HEX ******************

decode:

    CMP.B   D2,D1
    BEQ     return 

    CMP.B   #$30,(A2)
    BEQ     zero
    
    CMP.B   #$31,(A2)
    BEQ     one
    
    CMP.B   #$32,(A2)
    BEQ     two
    
    CMP.B   #$33,(A2)
    BEQ     three
    
    CMP.B   #$34,(A2)
    BEQ     four
    
    CMP.B   #$35,(A2)
    BEQ     five
    
    CMP.B   #$36,(A2)
    BEQ     six
    
    CMP.B   #$37,(A2)
    BEQ     seven
    
    CMP.B   #$38,(A2)
    BEQ     eight
    
    CMP.B   #$39,(A2)
    BEQ     nine
    
    CMP.B   #$41,(A2)
    BEQ     a

    CMP.B   #$42,(A2)
    BEQ     b

    CMP.B   #$43,(A2)
    BEQ     c

    CMP.B   #$44,(A2)
    BEQ     d
    
    CMP.B   #$45,(A2)
    BEQ     e

    CMP.B   #$46,(A2)
    BEQ     f   
   
return:
    RTS
   
zero:

    ASL.L   #4,D3
    ADDI.L  #$00,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

one:
    ASL.L   #4,D3
    ADDI.L  #$01,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

two:
    ASL.L   #4,D3
    ADDI.L  #$02,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    
    BRA     decode

three:
    ASL.L   #4,D3
    ADDI.L  #$03,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    
    BRA     decode

four:
    ASL.L   #4,D3
    ADDI.L  #$04,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    
    BRA     decode

five:
    ASL.L   #4,D3
    ADDI.L  #$05,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

six:
    ASL.L   #4,D3
    ADDI.L  #$06,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

seven:
    ASL.L   #4,D3
    ADDI.L  #$07,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

eight:
    ASL.L   #4,D3
    ADDI.L  #$08,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

nine:
    ASL.L   #4,D3
    ADDI.L  #$09,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

a:
    ASL.L   #4,D3
    ADDI.L  #$0A,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

b:
    ASL.L   #4,D3
    ADDI.L  #$0B,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

c:
    ASL.L   #4,D3
    ADDI.L  #$0C,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

d:
    ASL.L   #4,D3
    ADDI.L  #$0D,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

e:
    ASL.L   #4,D3
    ADDI.L  #$0E,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

f:
    ASL.L   #4,D3
    ADDI.L  #$0F,D3
    ADDQ    #1,A2
    ADDQ    #1,D2
    BRA     decode

invalid:
* display invalid message
    LEA     msginvalid, A1
    MOVE.B  #14,D0
    TRAP    #15

* display uncoded hex
    MOVE.W  -(A5), D1
    CLR.L D2
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15
    MOVE.W  (A5)+,D1
        
    RTS

******************** OPCODES *************************

* format as -memory location-  -opcode-  -operand-
* invalids displayed as  1000  DATA  -uncoded hex-
* each opcode should branch to the next if it is not that specific opcode

opcodes:

*------Liam-------

*------NOP-------
nop:
    CLR.L D5
    MOVE.W  #$FFFF,D5
    AND.W  D6,D5
    CMP.W   #%0100111001110001,D5
    BNE movea
    
    LEA msgnop,A1
    MOVE.W  #14,D0
    TRAP    #15
    
    RTS
  
*------MOVEA-------
movea:
    CLR.L D5
    MOVE.W  #%1100000111000000,D5
    AND.W  D6,D5
    CMP.W   #%0000000001000000,D5
    BNE move

    LEA msgmovea,A1
    MOVE.B  #14,D0
    TRAP    #15  

    JSR movesize  
    
    *Second part of EA
    CLR.L D3
    *Add source register to D3
    CLR.L D5
    MOVE.W  #%0000000000000111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
    *Add source mode to D3
    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D6,D5
    ADD.W   D5,D3
    
    *Add Size to D3
    CLR.L D5
    MOVE.W  #%0011000000000000,D5
    AND.W   D6,D5
    LSR.W   #6,D5
    ADD.W   D5,D3
    
    JSR ea
    
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    *Firest part of EA
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000111000000000,D5
    AND.W   D6,D5
    LSR.W   #6,D5 
    LSR.W   #3,D5
    ADD.W   D5,D3
   
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    LSR.W   #3,D5
    ADD.W  D5,D3
    
    *Add Size to D3
    CLR.L D5
    MOVE.W  #%0011000000000000,D5
    AND.W   D6,D5
    LSR.W   #6,D5
    ADD.W   D5,D3
    
    JSR ea

    RTS
*------MOVE-------
move:
    CLR.L D5
    MOVE.W  #%1100000000000000,D5
    AND.W   D6,D5
    CMP.W   #%0000000000000000,D5
    BNE     moveq
    
    CLR.L D5
    MOVE.W  #%0011000000000000,D5
    AND.W   D6,D5
    CMP.W   #%0000000000000000,D5
    BEQ     invalid
    
    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D6,D5
    CMP.W   #%0000000000110000,D5
    BEQ     invalid
    AND.W   D6,D5
    CMP.W   #%0000000000101000,D5
    BEQ     invalid
    
    
    LEA     msgmove,A1
    MOVE.B  #14,D0
    TRAP    #15
   
    JSR movesize
    
    *Second part of EA
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000000000000111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D6,D5
    ADD.W   D5,D3
    
    *Add Size to D3
    CLR.L D5
    MOVE.W  #%0011000000000000,D5
    AND.W   D6,D5
    LSR.W   #6,D5
    ADD.W   D5,D3
    
    JSR ea  
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    *Firest part of EA
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000111000000000,D5
    AND.W   D6,D5
    LSR.W   #6,D5 
    LSR.W   #3,D5 
    ADD.W   D5,D3
  
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    LSR.W   #3,D5
    ADD.W  D5,D3
    
    *Add Size to D3
    CLR.L D5
    MOVE.W  #%0011000000000000,D5
    AND.W   D6,D5
    LSR.W   #6,D5
    ADD.W   D5,D3    

    JSR ea
   
    RTS
*------MOVEQ-------
moveq:
    CLR.L D5
    MOVE.W  #%1111000100000000,D5
    AND.W   D6,D5
    CMP.W   #%0111000000000000,D5
    BNE movem
    
    LEA msgmoveq,A1
    MOVE.B  #14,D0
    TRAP    #15
    
 
    LEA msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA msgim,A1
    MOVE.B  #14,D0
    TRAP    #15
    

    LEA msghex,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1

    MOVE.W  #%0000000011111111,D1
    AND.W   D6,D1
    
    MOVE.B  #16,D2
    MOVE.B  #15,D0

    TRAP    #15
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    
    MOVE.W  #%0000111000000000,D5
    AND.W   D6,D5
    LSR.W   #7,D5
    LSR.W   #2,D5
    MOVE.W  D5,D3
    
    JSR ea
    
    RTS
*------MOVEM-------
movem: ** NOT COMPLETE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    CLR.L D5
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
    CLR.L D5
    MOVE.W  #%1111000000000000,D5
    AND.W  D6,D5
    CMP.W   #%1101000000000000,D5
    BNE addq
    
    * If ADDA then go there
    CLR.L D5
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
    
    LEA msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    CLR.L D2
    MOVE.W  #%0000000000000000,D2

    BRA addopchoice 
    
    RTS

addopchoice:
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP.W   #%0000000100000000,D5
    BGE     addc2
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
    JSR ea
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    ADD.W   D2,D3 * adds the type of register
    
    JSR ea
    
    RTS

addc2:
     
    CLR.L D3
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    ADD.W   D2,D3 * adds the type of register
    
    JSR ea
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
    JSR ea 
     
    RTS
*------ADDA-------
adda:

    LEA msgadda,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    JSR addasize

    
    CLR.L D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    ADD.W  D5,D3
    
    JSR ea
    
    * Print comma

    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    

    ADD.L   #%0000000000001000,D3 * adds the type of register
    
    JSR ea

    RTS


addac:


*------ADDQ-------
addq:
    CLR.L D5
    MOVE.W  #%1111000100000000,D5
    AND.W  D6,D5
    CMP.W   #%0101000000000000,D5
    BNE sub
    
    LEA msgaddq,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    
    JSR addqsize
    
    LEA msgim,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1
    MOVE.W  #%0000111000000000,D1
    AND.W   D6,D1
    LSR.W   #7,D1
    LSR.W   #2,D1
    
    MOVE.B  #3,D0
    TRAP    #15
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
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

addqsize:
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    
    CMP.W   #%0000000000000000,D5
    BEQ printbyte
    
    CMP.W   #%0000000001000000,D5 
    BEQ printword
    

    BRA printlong
 
*----------------END Liam-----------------------    

*------SUB-------

* format:
* |1001| register | opmode | <ea> mode | <ea> register
SUB:
    CLR.L D5
    MOVE.W	#%1111000000000000, D5
    AND.W	D6, D5
    CMP.W   #%1001000000000000, D5
    BNE		lea
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP.W   #%0000000011000000,D5
    BEQ     invalid
    
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP.W   #%0000000111000000,D5
    BEQ     invalid

* display opcode SUB
    LEA		msgsub, A1
    MOVE.B	#14, D0
    TRAP		#15

    JSR		subsize

    LEA    msgspace, A1
    MOVE.B #14, D0
    TRAP   #15 

    JSR subchoice
    

    RTS
    
subchoice:
    
    CLR.L D5
    MOVE.W  #%0000000111000000, D5
    AND.W   D6,D5
    CMP.W   #%0000000100000000, D5
    BGE     subc2
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
    JSR ea
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    JSR ea

    RTS 
    
subc2:
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    JSR ea
    
    * Print comma
    LEA msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    CLR.L D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    MOVE.W  D5,D3
    
    JSR ea
    
    
    RTS


* check size for SUB
subsize:

* check if byte
    CLR.L D5
    MOVE.W	#%0000000111000000, D5
    AND.W	D6, D5
    
    CMP.W	#%0000000000000000, D5
    BEQ		printbyte		        *size: byte and operation: Dn – < ea > ? Dn

    CMP.W	#%0000000100000000, D5
    BEQ		printbyte			        *size: byte and operation: < ea > – Dn ? < ea >

* check if word 
    CMP.W	#%0000000001000000, D5
    BEQ		printword		        *size: word and operation: Dn – < ea > ? Dn

    CMP.W	#%0000000101000000, D5
    BEQ		printword			        *size: word and operation: < ea > – Dn ? < ea >

* check if long 
    CMP.W	#%0000000010000000, D5
    BEQ		printlong		        *size: long and operation: Dn – < ea > ? Dn

    CMP.W	#%0000000110000000, D5
    BEQ		printlong		        *size: long and operation: < ea > – Dn ? < ea >

    BRA		invalid

* format: |0100| register | 111 | <ea> mode | <ea> register |
*------LEA-------
LEA:
    MOVE.W	#%1111000111000000, D5
    AND.W 	D6, D5
    CMP		#%0100000111000000, D5
    BNE		and

    LEA		msglea, A1
    MOVE.B	#14, D0
    TRAP	#15
    
    LEA     msgspace, A1
    MOVE.B  #14, D0
    TRAP    #15

    CLR.L D5
    CLR.L D3
    MOVE.W  #%0000000000111111, D3
    AND.W   D6,D3

    JSR     ea
    
    LEA     msgcomma, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    ADD.W   #%0000000000001000,D3
    
    JSR     ea

    RTS

*-------- JACOB -------------------

*------AND-------
and:
    MOVE.W  #%1111000000000000,D5
    AND.W   D6,D5
    CMP     #%1100000000000000,D5
    BNE     or
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP     #%0000000111000000,D5
    BEQ     invalid
    
    LEA     msgand,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L   D3
    JSR     aosize
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP     #%0000000100000000,D5
    BGE     aoc2
    
    CLR.L   D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    ADD.W   D5,D3   
    
    JSR     ea
    
    LEA     msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    JSR     ea
    
    RTS


*------OR-------
or:     *AND AND OR SIMILAR TO ADD, COULD COMBINE??
    MOVE.W  #%1111000000000000,D5
    AND.W   D6,D5
    CMP     #%1000000000000000,D5
    BNE     not
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     invalid
    
    LEA     msgor,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L   D3
    JSR     aosize
    
    CLR.L D5
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    CMP     #%0000000100000000,D5
    BGE     aoc2
    
    CLR.L   D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D6,D5
    ADD.W   D5,D3
    
    JSR     ea
    
    LEA     msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    JSR     ea
    
    RTS

aoc2:
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    JSR     ea  
    
    LEA     msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L   D3
    MOVE.W  #%0000000000111111,D3
    AND.W   D6,D3
    
    JSR     ea

    RTS
    
aosize:     *can be deleted??? same as addsize...
    MOVE.W  #%0000000111000000,D5
    AND.W   D6,D5
    
    CMP     #%0000000000000000,D5
    BEQ printbyte
    
    CMP     #%0000000100000000,D5
    BEQ printbyte
    
    CMP     #%0000000001000000,D5 
    BEQ printword
    
    CMP     #%0000000101000000,D5 
    BEQ printword
    
    BRA printlong 

*------NOT-------
not:
    MOVE.W  #%1111111100000000,D5
    AND.W   D6,D5
    CMP     #%0100011000000000,D5
    BNE     lslregshift
    
    LEA     msgnot,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     jsize
    
    MOVE.W  #%0000000000111111,D3
    AND.W   D6,D3
    
    JSR     ea
    
    RTS

*----- LSL REGISTER SHIFT -------
* format (register shift) LSL #<data>,Dy or LSL Dx,Dy
* |1110|count/register|1|size|i/r|01|register|

lslregshift:
    MOVE.W  #%1111000100011000,D5   *move binary to AND into D5
    AND.W   D6,D5
    CMP     #%1110000100001000,D5   *compare if is correct opcode
    BNE     lsrregshift             *if not equal branch to next opcode
    
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     lslmemshift
    
    LEA     msglsl,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     jsize
    
    CLR.L D5
    MOVE.W  #%0000000000100000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     shiftcount
    BNE     shiftreg
    
    RTS
    
*-------- LSR REGISTER SHIFT -------
* format (register shift) LSR #<data>,Dy or LSR Dx,Dy
* |1110|count/register|0|size|i/r|01|register|

lsrregshift:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000000001000,D5
    BNE     aslregshift
    
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     lslmemshift
    
    LEA     msglsr,A1
    MOVE.B  #14,D0
    TRAP    #15

    JSR     jsize
    
    CLR.L D5
    MOVE.W  #%0000000000100000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     shiftcount
    BNE     shiftreg
    
    RTS
    

*-------- ASL REGISTER SHIFT -------    
* format (register shift) ASL #<data>,Dy or ASL Dx,Dy
* |1110|count/register|1|size|i/r|00|register|

aslregshift:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000100000000,D5
    BNE     asrregshift
    
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     lslmemshift

    LEA     msgasl,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     jsize
    
    CLR.L D5
    MOVE.W  #%0000000000100000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     shiftcount
    BNE     shiftreg
    
    RTS

*-------- ASR REGISTER SHIFT -------
* format (register shift) ASR #<data>,Dy or ASR Dx,Dy
* |1110|count/register|0|size|i/r|00|register|

asrregshift:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000000000000,D5
    BNE     rolregrot
    
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     lslmemshift
    
    LEA     msgasr,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     jsize

    CLR.L D5
    MOVE.W  #%0000000000100000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     shiftcount
    BNE     shiftreg
    
    RTS
    

*-------- ROL REGISTER ROTATE -------
* format (register rotate) ROL #<data>,Dy or ROL Dx,Dy
* |1110|count/register|1|size|i/r|11|register|

rolregrot:
    MOVE.W  #%1110000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000100011000,D5
    BNE     rorregrot
    
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     lslmemshift
    
    LEA     msgrol,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     jsize
    
    CLR.L D5
    MOVE.W  #%0000000000100000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     shiftcount
    BNE     shiftreg
    
    RTS

*-------- ROR REGISTER ROTATE -------    
* format (register rotate) ROR #<data>,Dy or ROR Dx,Dy
* |1110|count/register|0|size|i/r|11|register|

rorregrot:
    MOVE.W  #%1111000100011000,D5
    AND.W   D6,D5
    CMP     #%1110000000011000,D5
    BNE     lslmemshift
    
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000011000000,D5
    BEQ     lslmemshift
    
    LEA     msgror,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     jsize

    CLR.L D5
    MOVE.W  #%0000000000100000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     shiftcount
    BNE     shiftreg
    
    RTS

jsize:
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D6,D5
    CMP     #%0000000000000000,D5
    BEQ     printbyte
    
    CMP     #%0000000001000000,D5
    BEQ     printword
    
    CMP     #%0000000010000000,D5
    BEQ     printlong
    
    RTS

shiftcount:

    LEA msgim,A1
    MOVE.B  #14,D0
    TRAP #15

    CLR.L D3
    MOVE.W  #%0000111000000000,D1
    AND.W   D6,D1
    LSR.W   #7,D1
    LSR.W   #2,D1
    
    MOVE.B  #3,D0
    TRAP    #15
    
    LEA     msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    MOVE.W  #%0000000000000111,D3
    AND.W   D6,D3
    
    JSR     ea
    
    RTS

shiftreg:
    CLR.L D3
    MOVE.W  #%0000111000000000,D3
    AND.W   D6,D3
    LSR.W   #7,D3
    LSR.W   #2,D3
    
    JSR     ea
    
    LEA     msgcomma,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D3
    MOVE.W  #%0000000000000111,D3
    AND.W   D6,D3
    
    JSR     ea
    
    RTS


*--------LSL MEMORY SHIFT--------
* format (memory shift) LSL <ea>
* |1110001111|EA mode|EA register|

lslmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110001111000000,D5
    BNE     lsrmemshift
    
    
    
    LEA     msglsl,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.W  D6,D3
    AND.W   #%0000000000111111,D3

    JSR     ea
    
    RTS

*--------LSR MEMORY SHIFT--------
* format (memory shift) LSR <ea>
* |1110001011|EA mode|EA register|

lsrmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110001011000000,D5
    BNE     aslmemshift
    
    LEA     msglsr,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.W  D6,D3
    AND.W   #%0000000000111111,D3

    JSR     ea
    
    RTS

*--------ASL MEMORY SHIFT--------
* format (memory shift) ASL <ea>
* |1110000111|EA mode|EA register|

aslmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110000111000000,D5
    BNE     asrmemshift
    
    LEA     msgasl,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.W  D6,D3
    AND.W   #%0000000000111111,D3

    JSR     ea
    
    RTS

*--------ASR MEMORY SHIFT--------
* format (memory shift) ASR <ea>
* |1110000011|EA mode|EA register|

asrmemshift:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110000011000000,D5
    BNE     rolmemrot
    
    LEA     msgasr,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.W  D6,D3
    AND.W   #%0000000000111111,D3

    JSR     ea
    
    RTS

*--------ROL MEMORY SHIFT--------
* format (memory rotate) ROL <ea>
* |1110011111|EA mode|EA register|

rolmemrot:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110011111000000,D5
    BNE     rormemrot
    
    LEA     msgrol,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.W  D6,D3
    AND.W   #%0000000000111111,D3

    JSR     ea
    
    RTS

*--------ROR MEMORY SHIFT--------
* format (memory rotate) ROR <ea>
* |1110011011|EA mode|EA register|

rormemrot:
    MOVE.W  #%1111111111000000,D5
    AND.W   D6,D5
    CMP     #%1110011011000000,D5
    BNE     BGT
    
    LEA     msgror,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.W  D6,D3
    AND.W   #%0000000000111111,D3
    
    JSR     ea
    
    RTS

* ---------- END of JACOB -----------


*------RACHEL-----

* Bcc format: |0110| 1110 | 8-bit Displacement
*------BGT-------

BGT:
    MOVE.W	#%1111111100000000, D5
    AND.W	D6, D5
    CMP		#%0110111000000000, D5
    BNE		BLE

* display BGT opcode
    LEA		msgbgt, A1
    MOVE.B	#14, D0
    TRAP	#15

    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    JSR bccdisplacement
    
    RTS

* Bcc format: |0110| 1111 | 8-bit Displacement
*------BLE-------

BLE:
    MOVE.W	#%1111111100000000, D5
    AND.W	D6, D5
    CMP		#%0110111100000000, D5
    BNE		BEQ

* display BLE opcode
    LEA		msgble, A1
    MOVE.B	#14, D0
    TRAP	#15

    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    JSR bccdisplacement

    RTS

* Bcc format: |0110| 0111 | 8-bit Displacement
*------BEQ-------

BEQ:
    MOVE.W	#%1111111100000000, D5
    AND.W	D6, D5
    CMP		#%0110011100000000, D5
    BNE		JSR

* display BEQ opcode
    LEA		msgbeq, A1
    MOVE.B	#14, D0
    TRAP	#15

    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    JSR bccdisplacement

    RTS


* format: |0100111010| <ea> mode | <ea> register |
*------JSR-------

JSR:
    MOVE.W	#%1111111111000000, D5
    AND.W	D6, D5
    CMP		#%0100111010000000, D5
    BNE		RTS

* display JSR opcode
    LEA		msgjsr, A1
    MOVE.B	#14, D0
    TRAP	#15

    CLR.L D5
    CLR.L D3
    MOVE.W  #%0000000000111111, D3
    AND.W   D6,D3

    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    JSR ea

    RTS

* format: |0100111001110101|
*------RTS-------

RTS:
    MOVE.W	#%1111111111111111, D5
    AND.W	D6, D5
    CMP		#%0100111001110101, D5
    BNE		BRA

* display RTS opcode
    LEA		msgrts, A1
    MOVE.B	#14, D0
    TRAP	#15

    RTS

* format: |01100000| 8-bit displacement |
*------BRA-------
BRA:

    MOVE.W	#%1111111100000000, D5
    AND.W	D6, D5
    CMP 	#%0110000000000000, D5
    BNE		invalid				        *reached end of all opcode tests

* display BRA opcode
    LEA		msgbra, A1
    MOVE.B	#14, D0
    TRAP	#15

    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    LEA     msgspace,A1
    MOVE.B  #14,D0
    TRAP    #15

    JSR bccdisplacement

    RTS


bccdisplacement:
    
    CLR.L D5
    MOVE.W  #%0000000011111111,D5
    AND.W   D6,D5
    CMP.W   #%0000000000000000,D5
    BEQ     sbit

    CMP.W   #%0000000011111111,D5
    BEQ     tbit

    LEA     msghex,A1
    MOVE.B  #14,D0
    TRAP    #15


    CLR.L D2
    MOVE.L  A5,D2

    MOVE.W  D5,D1
    
    ADD.W   D2,D1
    

    CLR.L D2
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15

    RTS

sbit:

    LEA     msghex,A1
    MOVE.B  #14,D0
    TRAP    #15

    
    CLR.L D2
    MOVE.L  A5,D2

    * 16 bit
    CLR.L D1
    MOVE.W  (A5)+,D1
    ADD.W   D2,D1
    

    CLR.L D2
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15

    RTS 

tbit:

    LEA     msghex,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D2
    MOVE.L  A5,D2
    
    
    * 32 bit
    MOVE.L  (A5)+,D1
    ADD.L   D2,D1
    

    CLR.L D2
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15

    RTS

* ------- END of RACHEL --------------

*------- Printing of sections --------
printbyte:

    LEA msgbyte,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    ADD.L   #%0000000001000000,D3
    
    RTS

printword:
    LEA msgword,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    ADD.L   #%0000000011000000,D3
    
    RTS

printlong:
    LEA msglong,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    ADD.L   #%0000000010000000,D3
    
    RTS   


* -------- EA -------------- *  
ea:

eadrd:

    * Check D3

    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D3,D5
    CMP.W   #%0000000000000000,D5
    BNE     eaid


    LEA msgdatar,A1
    MOVE.B  #14,D0
    TRAP #15
    
    CLR.L D1
    MOVE.W  #%0000000000000111,D1
    AND.W   D3,D1
    
    MOVE.B  #3,D0
    TRAP    #15
    
    RTS

*----IMEDIATE DATA------
eaid:
    
    CLR.L D5
    MOVE.W  #%0000000000111111,D5
    AND.W   D3,D5
    CMP.W   #%0000000000111100,D5
    BNE     eaard
    
    * Check D3
    LEA msgim,A1
    MOVE.B  #14,D0
    TRAP #15
    
    LEA msghex,A1
    MOVE.B  #14,D0
    TRAP #15
    
    * load correct data to D1
    CLR.L D1
    JSR moveidata
    
    *print data
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15
    
    RTS

* Moves the appropriate immediate data to D1
moveidata:
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D3,D5
    CMP.W   #%0000000001000000,D5
    BNE     lword

    *byte
    MOVE.W  (A5)+,D1
    
    RTS
lword:
    CLR.L D5
    MOVE.W  #%0000000011000000,D5
    AND.W   D3,D5
    CMP.W   #%0000000011000000,D5
    BNE     llong
    
    *word
    MOVE.W  (A5)+,D1
    
    RTS
llong:

    *long
    MOVE.L  (A5)+,D1
    RTS

*----ADDRESS REGISTER DIRECT---
eaard:

    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D3,D5
    CMP.W   #%0000000000001000,D5
    BNE     eaari
    
    LEA     msgaddrr,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1
    MOVE.W  #%0000000000000111,D1
    AND.W   D3,D1
    
    MOVE.B  #3,D0
    TRAP    #15

    RTS

*----ADDRESS REGISTER INDIRECT----
eaari:

    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D3,D5
    CMP.W   #%0000000000010000,D5
    BNE     eaadrpost

    LEA     msgparopen,A1
    MOVE.B  #14,D0
    TRAP    #15

    LEA     msgaddrr,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1
    MOVE.W  #%0000000000000111,D1
    AND.W   D3,D1
    
    MOVE.B  #3,D0
    TRAP    #15
    
    LEA     msgparclose,A1
    MOVE.B  #14,D0
    TRAP    #15

    RTS


*-----JACOB-----

*----ADDRESS REGISTER INDIRECT WITH POST INCREMENTING----
eaadrpost:
    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D3,D5
    CMP.W   #%0000000000011000,D5
    BNE     eaadrpre

    LEA     msgparopen, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgaddrr, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1
    MOVE.W  #%0000000000000111,D1
    AND.W   D3,D1
    
    MOVE.B  #3,D0
    TRAP    #15
    
    LEA     msgparclose,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgplus,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    RTS
    

*----ADDRESS REGISTER INDIRECT WITH PRE INCREMENTING----
eaadrpre:
    CLR.L D5
    MOVE.W  #%0000000000111000,D5
    AND.W   D3,D5
    CMP.W   #%0000000000100000,D5
    BNE     eaala
    
    LEA     msgminus,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgparopen, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     msgaddrr, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D1
    MOVE.W  #%0000000000000111,D1
    AND.W   D3,D1
    
    MOVE.B  #3,D0
    TRAP    #15
    
    LEA     msgparclose,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    RTS

*----RACHEL-----

* | 111 | 001 |
eaala:
    CLR.L D5
    MOVE.W  #%0000000000111111, D5
    AND.W   D3, D5
    CMP.W   #%0000000000111001, D5
    BNE     eaawa
    
    LEA     msghex,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D2
    MOVE.L  (A5)+,D1
    MOVE.B  #16,D2
    MOVE.B  #15,D0
    TRAP    #15
    
    RTS

*----ABSOLUTE WORD ADDRESS----
* | 111 | 000 |
eaawa:
    CLR.L D5
    MOVE.W  #%0000000000111111, D5
    AND.W   D3, D5
    CMP.W   #%0000000000111000, D5
    BNE     invalid
    
    LEA     msghex,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L D2
    MOVE.W  (A5)+,D1
    MOVE.B  #16,D2

    MOVE.B  #15,D0
    TRAP    #15

    RTS
    

******************* CONSTANTS ************************

CR  EQU $0D
LF  EQU $0A

WMSG         DC.B   'Welcome to Group 3s X68000 Dissassembler!',CR,LF
             DC.B   'First make sure to load your program into memory',CR,LF
             DC.B   'Next enter two memory addresses, the start and end of',CR,LF
             DC.B   'your program',CR,LF,0
SPACE        DC.B   '',CR,LF,0
ENTERMSG1    DC.B   'Enter starting address: ',0
ENTERMSG2    DC.B   'Enter ending address: ',0 

msgenter1    DC.B   'Enter starting address: ',0
msgenter2    DC.B   'Enter ending address: ',0 

msgask       DC.B   'Would you like to dissasemble a program (y/n)? ',0

msgmove      DC.B   'MOVE',0
msgmovea     DC.B   'MOVEA',0
msgmoveq     DC.B   'MOVEQ',0
msgmovem     DC.B   'MOVEM',0
msgadd       DC.B   'ADD',0
msgadda      DC.B   'ADDA',0
msgaddq      DC.B   'ADDQ',0
msgnop       DC.B   'NOP',0

msglsl       DC.B   'LSL',0
msglsr       DC.B   'LSR',0
msgasl       DC.B   'ASL',0
msgasr       DC.B   'ASR',0
msgrol       DC.B   'ROL',0
msgror       DC.B   'ROR',0
msgnot       DC.B   'NOT',0
msgor        DC.B   'OR',0
msgand       DC.B   'AND',0

msgsub       DC.B   'SUB',0
msglea       DC.B   'LEA',0
msgbra       DC.B   'BRA',0
msgjsr       DC.B   'JSR',0
msgrts       DC.B   'RTS',0
msgbeq       DC.B   'BEQ',0
msgble       DC.B   'BLE',0
msgbgt       DC.B   'BGT',0


msgbyte      DC.B   '.B ',0
msgword      DC.B   '.W ',0
msglong      DC.B   '.L ',0

msgdatar     DC.B   'D',0
msgim        DC.B   '#',0
msgaddrr     DC.B   'A',0
msgcomma     DC.B   ',',0
msgspace     DC.B   ' ',0
msgparopen   DC.B   '(',0
msgparclose  DC.B   ')',0
msgplus      DC.B   '+',0
msgminus     DC.B   '-',0

msghex       DC.B   '$',0

msgenter     DC.B   'Press Enter to Continue',CR,LF,0
msginvalid   DC.B   'DATA ',0

counter      DS.B   1



  
    END     START




























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
