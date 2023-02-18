.model tiny
.code


org 100h

;-------------------------------------------------------------------------------------------
;     This programm output the string from the commond line to the center of the console
;-------------------------------------------------------------------------------------------

Begin:        
            mov ax, 0b800h ;video memory segment
            mov es, ax
            mov cl, ds:[80h]  

            mov si, 82h
            mov di, (80*12 + 30)*2

            dec cl     ; dont print 0dh symbol
			cmp cl, -1
			je ending ; if console's string is empty

Cicle:        		

            mov al, ds:[si]
            mov ah, 00010010b  ;green on blue
            mov es:[di], ax

            add di, 2
            inc si
            loop Cicle

			ending:


            mov ax, 4c00h
            int 21h

end            Begin

