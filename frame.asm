.model tiny
.code

org 100h

.data
Max_y_size = 25
left_x     = 10
left_y     = 24
width_ram  = 20
length_ram = 54
;        Check_params_on_valid:
;                         mov al, left_y
;                         mov ah, Max_y_size
;                         cmp al, ah
;                         jb  Valid_y_param

;                         mov ah, 09h
;                         mov dx, offset error
;                         int 21h

;                         Valid_y_param:


;                         ret
;                         endp

Ramochka:
        ;call Check_params_on_valid

        Left_koords EQU ((25 - left_y)*80 + left_x)*2
        mov al, 04h
        mov ah, 01100001b

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


        mov ax, 4c00h
        int 21h
          

.data
     error db "invalid y$"
     size_err EQU $ - error

end Ramochka

/m2