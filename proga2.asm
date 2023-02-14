.model tiny
.code

org 100h


Start:			
			mov ax, 0d

			mov bx, 0b800h
			mov es, bx
			mov bl, 2
			mov di, (80*12 + 30)*2
			std    ; flag df is activated(di -= 2 every time)
			call To_Binary
			ret

To_Binary:
		
		Cicle:

			div bl

			add ah, 48
			mov dh, al
	
			mov al, 00010100b

			xchg ah, al

			stosw

			mov ah, 0
			mov al, dh

			cmp al, 0
			jne Cicle

			ret
			endp
	

end Start