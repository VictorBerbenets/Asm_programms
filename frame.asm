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

        mov al, 03h
        mov ah, 00100100b
        add di, (80 - length_ram)*2 ; di points to the component of the right vertical line

        stosw

        push cx
        push di
;;;;;;;;;;;;;Filling ram space;;;;;;;;;;;;;;;;
        mov cx, length_ram - 2
        mov al, 20h
        mov ah, 00110000b
        Fill_String:

        stosw

        loop Fill_String
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop di
        pop cx

        mov al, 03h
        mov ah, 00100100b

        add di, (length_ram - 2)*2     ; di points to the component of the left  vertical line

        stosw
        dec cx

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
        TextStart EQU (80*(25 - left_y + 2) + left_x + 10)*2
        mov ax, 0b800h
        mov es, ax
        xor ax, ax
        xor si, si
	mov di, TextStart
        xor bl, bl
        mov cx, str_size

        cld
        Cycle:
        
        mov al, [string + si]
        mov ah, 01110100b
        inc bl
        stosw

        cmp bl, 16
        jne Skip
                add di, (80 - 16)*2 
                xor bl, bl
        Skip:
        inc si
        loop Cycle

        mov ax, 4c00h
	int 21h

.data

Max_y_size = 22
left_x     = 26
left_y     = 20
width_ram  = 10
length_ram = 38

string db 'Hello world'
str_size EQU $ - string

end Ramochka

/m2