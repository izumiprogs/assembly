; multi-segment executable file template.

data segment
    ; add your data here! 
    S dw ?
    N dw ?
    perenos db 13,10,"$"
    vvod_N db 13,10,"Vvedite N=$"
    vivod_S db "S=$"
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
    
    XOR AX, AX
    MOV DX, offset vvod_N
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 30h
    cbw
    mov N, AX
    
    MOV AX, 0
    MOV CX, N
    MOV BX, 3
    MOV DX, 2
    
@repeat:
    add AX, BX
    add BX, DX
    INC DX
    loop @repeat
    
    MOV S, AX
    
    MOV DX, offset perenos
    mov ah, 9
    int 21h
    
    mov dx, offset vivod_S
    mov ah, 9
    int 21h
    
    mov ax, S
   
Lower:
    push -1
    mov cx, 10
    
L1:
    mov dx, 0
    div cx
    push dx 
    cmp ax, 0
    jne L1
    mov ah, 2  
L2:
    pop dx
    cmp dx, -1
    je sled8
    add dl, 30h
    int 21h
    jmp L2
 
sled8:
    mov dx, offset perenos 
    mov ah, 9
    int 21h
    
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
