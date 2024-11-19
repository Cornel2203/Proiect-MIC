name "Parking Meter"

org 100h

.model small
.stack 100h

.data
; Titlul
msg_title_top db "+==============================================================================+$", 10, 13
msg_title_inner db "||                          -Parcometru in Functiune-                         ||$", 10, 13
msg_title_bottom db "+==============================================================================+$", 10, 13

; Lista numerelor de înmatriculare, zonele ?i costurile
msg_db db "+------------------------------+     +----Zone----+    +--------Price--------+", 10, 13
        db " | PH 41 CRC: Afara           |            Z0           |  1 ora: 10 Lei    |", 10, 13
        db " | PH 87 MOX: Afara           |                                              ", 10, 13
        db " | BV 34 MIS: Afara           |            Z1           |  2 ore: 15 Lei    |", 10, 13
        db " | B 146 SYS: Afara           |                                              ", 10, 13
        db " | BV 89 DXP: Afara           |            Z2           |  24 ore: 50 Lei   |", 10, 13
        db "+------------------------------+     +------------+    +---------------------+", 10, 13

; Linie separatoare pentru intrari
msg_separator db "+==============================================================================+$", 10, 13

; Input rectangles
msg_input_top db "+-------------------------------+ +---------------------+ +--------------------+$", 10, 13
msg_input_nr db "| Introdu nr. de inmatriculare: | |    Introdu zona:    | |  Introdu timpul:   |$", 10, 13
msg_input_empty db "|                               | |                     | |                    |$", 10, 13
msg_input_bottom db "+-------------------------------+ +---------------------+ +--------------------+$", 10, 13

.code
main proc
    ; Ini?ializeaza segmentul de date
    mov ax, @data
    mov ds, ax

    ; Cura?a ecranul
    mov ah, 0   ; Seteaza modul video
    mov al, 3   ; Modul text 80x25
    int 10h

    ; Afi?eaza titlul
    lea dx, msg_title_top
    call print_message
    lea dx, msg_title_inner
    call print_message
    lea dx, msg_title_bottom
    call print_message

    ; Afi?eaza lista numerelor de înmatriculare cu zonele ?i costurile
    lea dx, msg_db
    call print_message

    ; Afi?eaza separatorul înaintea dreptunghiurilor de intrare
    ;lea dx, msg_separator
    ;call print_message

    ; Afi?eaza dreptunghiurile pentru introducerea datelor
    lea dx, msg_input_top
    call print_message
    lea dx, msg_input_nr
    call print_message
    lea dx, msg_input_empty
    call print_message
    lea dx, msg_input_bottom
    call print_message

    ; Termina programul
    mov ah, 4Ch
    int 21h
main endp

; Procedura pentru afi?area unui mesaj
print_message proc
    mov ah, 09h    ; Func?ia de afi?are a ?irului
    int 21h
    ret
print_message endp

end main
