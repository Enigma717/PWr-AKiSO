; Marek Traczyński (261748) Zadanie 1
; Funkcja 'itoh' potrzebna do wykonania zadania
; znajduje się na końcu pliku functions.asm

%include 'functions.asm'
 
SECTION .data
    msg1    db    'Enter number in DEC: ', 0h
    msg2    db    'Your number in HEX: ', 0h 
 
SECTION .bss
    userinput:    resb    10
 
SECTION .text
    global _start

_start:
 
    mov     eax, msg1
    call    sprint

    mov     edx, 10             
    mov     ecx, userinput      
    mov     ebx, 0              
    mov     eax, 3              
    int     80h

    mov     eax, msg2
    call    sprint

    mov     eax, userinput
    call    atoi                    ; String (ASCII) to integer (decimal)
    call    itoh                    ; Integer to hexadecimal
    int     80h 
 
    call    quit