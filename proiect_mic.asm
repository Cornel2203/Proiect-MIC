name "Parking Meter"

org 100h

.model small
.stack 100h
.data
; Title Section
msg_title_top db "+==============================================================================+$", 0
msg_title_inner db "|                              Parking Meter System                            |$", 0
msg_title_bottom db "+==============================================================================+$", 0

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Clear the screen
    mov ah, 0   ; Set video mode
    mov al, 3   ; 80x25 text mode
    int 10h

    ; Display the title
    lea dx, msg_title_top
    call print_message
    lea dx, msg_title_inner
    call print_message
    lea dx, msg_title_bottom
    call print_message

    ; End program
    mov ah, 4Ch
    int 21h
main endp

; Print a null-terminated message
print_message proc
    mov ah, 09h
    int 21h
    ret
print_message endp

end main
