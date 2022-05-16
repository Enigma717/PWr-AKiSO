; Marek Traczyński (261748) Zadanie 1
; Poniższe funkcje są zapożyczone ze strony asmtutor.com
; Funkcje potrzebne do zadania (itobcd oraz bcdprint) są napisane własnoręcznie na podstawie atoi z powyższej strony

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


;============================================================

;===================================
; Decimal to BCD conversion
;===================================

itobcd:
    push    eax 
    push    ebx
    push    ecx
    push    edx

    mov     ecx, 0

    .divisionloop:
        mov     edx, 0        
        mov     ebx, 10 
        inc     ecx                        
        idiv    ebx                  
        push    edx
        cmp     eax, 0        
        jnz     .divisionloop
 
    .printfromstack:
        dec     ecx
        pop     eax
        call    bcdprint
        cmp     ecx, 0
        jnz     .printfromstack
        call    linefeed

    .restore:
        pop     edx               
        pop     ecx                 
        pop     ebx
        pop     eax

        ret

;===================================
; Print BCD
;=================================== 

bcdprint:
    push    eax                   
    push    ecx                   
    push    edx                   
    push    ebx

    mov     ecx, 0            

    .divisionloop:
        mov     edx, 0           
        mov     ebx, 2 
        inc     ecx                       
        idiv    ebx              
        push    edx              
        cmp     ecx, 3           
        jle     .divisionloop        
    
    .printfromstack:
        dec     ecx
        mov     eax, esp
        pop     eax              
        call    iprint           
        cmp     ecx, 0           
        jg      .printfromstack
        call    space

    .restore:
        pop     ebx
        pop     edx
        pop     ecx
        pop     eax

        ret

;===================================
; Print new line
;===================================

linefeed:
    push      eax      
    mov       eax, 0Ah 
    push      eax         
    mov       eax, esp 
    call      sprint   
    pop       eax         
    pop       eax 

    ret

;===================================
; Print space
;===================================

space:
    push      eax      
    mov       eax, 20h 
    push      eax         
    mov       eax, esp 
    call      sprint   
    pop       eax         
    pop       eax 

    ret