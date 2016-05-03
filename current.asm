GETSTR MACRO STR
MOV AH,0AH
LEA DX,STR
INT 21H
ENDM

PRINTSTR MACRO STR
MOV AH,09H
LEA DX,STR
INT 21H
ENDM

DATA SEGMENT

        STR1 DB 80,80 DUP('$')
        STR2 DB 80,80 DUP('$')
        read1 DB 10,13,'ENTER THE FIRST STRING :$'
        read2 DB 10,13,'ENTER THE SECOND STRING IS :$'
        MSG3 DB 10,13,'THE TWO STRINGS ARE EQUAL$'
        MSG4 DB 10,13,'THE TWO STRINGS ARE NOT EQUAL$'
DATA ENDS

CODE SEGMENT

        ASSUME CS:CODE,DS:DATA,ES:DATA
        START:

                 MOV AX,DATA
                 MOV ES,AX
                 MOV DS,AX
        
                 PRINTSTR read1
                 GETSTR STR1
                 PRINTSTR read2
                 GETSTR STR2
               
                 LEA SI,STR1+2
                 LEA DI,STR2+2
               
                 MOV CL,STR1+1 ;FOR STORING THE LENGTH OF THE STRING
                 MOV CH,00H
                 REPE CMPSB
                 JNE NOTEQUAL
        
                 PRINTSTR MSG3
                 JMP JAY1
        
             NOTEQUAL:
                 PRINTSTR MSG4
        
             JAY1:      
                 MOV AX,4C00H
                 INT 21H
        
CODE ENDS
        END START