; Marek Traczyński (261748) Zadanie 1
; Poniższe funkcje są zapożyczone ze strony asmtutor.com
; Funkcja potrzebna do zadania (itoh) jest napisana własnoręcznie na podstawie atoi z powyższej strony

iprint:
    push    eax             
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          
 
    .divideLoop:
        inc     ecx             
        mov     edx, 0          
        mov     esi, 10         
        idiv    esi             
        add     edx, 48         
        push    edx             
        cmp     eax, 0          
        jnz     .divideLoop      
 
    .printLoop:
        dec     ecx             
        mov     eax, esp        
        call    sprint          
        pop     eax             
        cmp     ecx, 0          
        jnz     .printLoop       
    
        pop     esi             
        pop     edx             
        pop     ecx             
        pop     eax             
        ret
 

iprintLF:
    call    iprint         
 
    push    eax            
    mov     eax, 0Ah       
    push    eax            
    mov     eax, esp       
    call    sprint         
    pop     eax            
    pop     eax            
    ret
 

slen:
    push    ebx
    mov     ebx, eax
 
    .nextchar:
        cmp     byte [eax], 0
        jz      .finished
        inc     eax
        jmp     .nextchar
 
    .finished:
        sub     eax, ebx
        pop     ebx
        ret
 

sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret
 

sprintLF:
    call    sprint
 
    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret


atoi:
    push    ebx             
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        
    mov     eax, 0          
    mov     ecx, 0          
 
    .multiplyLoop:
        xor     ebx, ebx        
        mov     bl, [esi+ecx]   
        cmp     bl, 48          
        jl      .finished       
        cmp     bl, 57          
        jg      .finished       
    
        sub     bl, 48          
        add     eax, ebx        
        mov     ebx, 10         
        mul     ebx             
        inc     ecx             
        jmp     .multiplyLoop   
 
    .finished:
        cmp     ecx, 0          
        je      .restore        
        mov     ebx, 10         
        div     ebx             
 
    .restore:
        pop     esi             
        pop     edx             
        pop     ecx             
        pop     ebx             
        ret
 

quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret


;===================================
; Decimal to hexadecimal conversion
;===================================

itoh:
    push    eax
    push    ebx             
    push    ecx             
    push    edx      

    mov     ecx, 0
    mov     edx, 0Ah
    push    edx
    inc     ecx
    
    .divisionloop:
        mov     edx, 0
        mov     ebx, 16
        inc     ecx
        idiv    ebx
        cmp     edx, 10
        jge     .numbertoletter
        add     edx, 48
        push    edx
        cmp     eax, 0
        jne     .divisionloop
        jmp     .printfromstack
 
    .numbertoletter:
        add     edx, 55
        push    edx
        cmp     eax, 0
        jne     .divisionloop
 
    .printfromstack:
        dec     ecx
        mov     eax, esp
        call    sprint
        pop     eax
        cmp     ecx, 0
        jne     .printfromstack

    .restore:
        pop     esi            
        pop     edx            
        pop     ecx            
        pop     ebx 
                   
        ret
