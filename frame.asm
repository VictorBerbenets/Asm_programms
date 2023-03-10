.model tiny
.code

org 100h



Ramochka:

        Left_koords EQU ((25 - left_y)*80 + left_x)*2
        mov al, 03h
        mov ah, 00100100b

        mov cx, length_ram*2

        mov bx, 0b800h
        mov es, bx
        mov di, Left_koords

;printing gorizontal line of the frame
Gorizont_up: ; up gorizontal line of the frame
          
        stosw
        sub cx, 2
        cmp cx, 0
        ja Gorizont_up

        mov cx, (width_ram - 1)

Verticals:  ;print vertical lines of the frame

        add di, (80 - length_ram)*2 ; di points to the component of the right vertical line

        stosw

        add di, (length_ram - 2)*2     ; di points to the component of the left  vertical line

        stosw
        sub cx, 1

        cmp cx, 0
        ja Verticals

        std
        mov cx, length_ram - 1
        sub di, 2
Print_bottom_line:
        
        stosw

        sub cx, 1
        cmp cx, 0
        ja Print_bottom_line

Print_Text:

        ; mov dx,  text
        mov ax, 0b800h
        mov es, ax
        xor ax, ax
        xor si, si
	mov di, (80*12 + 30)*2
        mov cx, str_size

        cld
        Cycle:
        
        mov al, [string + si]
        mov ah, 00000100b
        stosw
        inc si
        loop Cycle

        mov ax, 4c00h
	int 21h

.data

Max_y_size = 22
left_x     = 10
left_y     = 23
width_ram  = 20
length_ram = 54

;;;;;;;;;;;;;;;;;; Text ;;;;;;;;;;;;;;;;;;;;;;;
string db 'Hello, world!!!'
str_size EQU $ - string
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end Ramochka

/m2