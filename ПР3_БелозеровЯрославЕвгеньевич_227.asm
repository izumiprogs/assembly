; multi-segment executable file template.

data segment 
    ; add your data here!   
    A DB ? 
    X DB ? 
    Y Dw ? 
    Y1 Db ? 
    Y2 Dw ? 
    PERENOS DB 13,10,"$" 
    VVOD_A DB 13,10,"Enter A=$" 
    VVOD_X DB 13,10,"Enter X=$",13,10 
    VIVOD_Y DB "Result Y=$" 
    pkey db "press any key...$" 
ends 
 
stack segment 
    dw   128  dup(0) 
ends 
 
code segment 
start: 
; set segment registers: 
    mov ax, data 
    mov ds, ax 
    mov es, ax 
 
    ; add your code here  
     
    XOR AX,AX 
    MOV DX,OFFSET VVOD_A 
    MOV AH,9 
    INT 21H 
     
    METKA1: 
    MOV AH,1 
    INT 21H 
    CMP AL,"-" 
    JNZ METKA2 
    MOV BX,1 
    JMP METKA1 
     
    METKA2: 
    SUB AL,30H 
    TEST BX,BX 
    JZ METKA3 
    NEG AL 
     
    METKA3: 
    MOV A,AL 
    XOR AX,AX 
    XOR BX,BX 
    MOV DX,OFFSET VVOD_X 
    MOV AH,9 
    INT 21H 
     
    METKA4: 
    MOV AH,1 
    INT 21H 
    CMP AL,"-" 
    JNZ METKA5 
    MOV BX,1 
    JMP METKA4 
     
    METKA5: 
    SUB AL,30H 
    TEST BX,BX 
    JZ METKA6 
    NEG AL 
     
    METKA6: 
    MOV X,AL 
    MOV AL,A 
    ;GET Y1 
    MOV CH,2H 
    MOV CL,3H 
    CMP CH,X 
    JG @LEFT1 
    ADD AL,CL 
    JMP @RETURN1 
    @LEFT1: 
    MOV AL,CH 
    MOV CH,X 
    SUB AL,CH 
    @RETURN1: 
    MOV Y1,AL 
    ;GET Y2 
    MOV AL,A
    mov AH, 0 
    CMP AL,X 
    JG @LEFT2
    MOV BL,X 
    MUL BL 
    MOV CX,1H 
    SUB AX,CX 
    JMP @RETURN2 
    @LEFT2: 
    MOV AH,1 
    SUB AL,AH 
    MOV AH,0 
    CBW 
    @RETURN2: 
    MOV Y2,AX 
    ;GET Y 
    MOV AH,0 
    MOV AL,Y1 
    CBW 
    MOV CX,Y2 
    ADD AX,CX 
    MOV Y,AX 
     
    MOV DX,OFFSET PERENOS 
    XOR AX,AX 
    MOV AH,9 
    INT 21H 
     
    MOV DX,OFFSET VIVOD_Y 
    MOV AH,9 
    INT 21H 
    MOV CX,Y 
    CMP Y,0 
    JGE METKA7 
    NEG CX 
    MOV BX,CX 
    MOV DL,"-" 
    MOV AH,2 
    INT 21H 
    MOV DX,BX 
    ADD DX,30H 
    INT 21H 
    JMP METKA8 
     
    METKA7: 
    MOV DX,Y 
    ADD DX,30H 
    MOV AH,2H 
    INT 21H 
     
    METKA8: 
    MOV DX,OFFSET PERENOS 
    MOV AH,9 
    INT 21H 
     
    MOV AH,1 
    INT 21H 
     
    MOV AX,4C00H 
    INT 21H 
     
     
     
             
    ;lea dx, pkey 
    ;mov ah, 9 
    ;int 21h        ; output string at ds:dx 
     
    ; wait for any key....     
    ;mov ah, 1 
    ;int 21h 
     
    ;mov ax, 4c00h ; exit to operating system. 
    ;int 21h     
end start ; set entry point and stop the assembler.
