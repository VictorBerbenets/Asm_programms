.model tiny
.code


org 100h


Begin:        ;mov ds, 80h
              mov ax, 0b800h
              mov es, ax
              mov cl, ds:[80h]  
              dec cx     
              mov si, 82h
              xor di, di 

Cicle:        

            mov al, ds:[si]
            mov ah, 4eh 
            mov es:[di], ax
            add di, 2
            inc si
            dec cx
            cmp cx, 0
            jne Cicle

            mov ax, 4c00h
            int 21h
//
  ; lods   BYTE PTR es:[si] 
end            Begin