.model tiny
.code

org 100h

;This programm prints string to the middle of the skrin

Begin: 

        mov ax, 0b800h
        mov es, ax

        xor ax, ax
        xor si, si
		mov di, (80*12 + 30)*2
        
        mov cx, str_size

        Cycle:
        
        mov bl, [string + si]
        mov bh, 10100100b
        mov word ptr es:[di], bx
        inc si
		add di, 2
        dec cx

        cmp cx, 0
        jne Cycle

        mov ax, 4c00h
		int 21h

.data
string db 'Da da eto gestkooo, seems like carnage'
str_size EQU $ - string

end            Begin