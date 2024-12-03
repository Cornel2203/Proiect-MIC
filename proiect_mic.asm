name "Parking Meter"

org 100h

.model small
.stack 100h

.data
; Titlul
msg_title_top db "+==============================================================================+$", 10, 13
msg_title_inner db "||                          -Parcometru in Functiune-                         ||$", 10, 13
msg_title_bottom db "+==============================================================================+$", 10, 13

; Lista numerelor de inmatriculare, zonele si costurile
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

msg_verif_box db "        |              |              |             |        |              |$", 10, 13
msg_verif_line db "           +--------------+              +-------------+        +--------------+$", 10, 13

msg_verified db "Verificat$"
msg_invalid db "Invalid  $"
clear_text db "       $"

; Buffere pentru introducere
user_input db 7 dup(' ') ; Buffer pentru introducerea utilizatorului
valid_numbers db "PH41CRC PH87MOX", "BV34MIS", "B146SYS", "BV89DXP", 0

.code
main proc
    ; Initializeaza segmentul de date
    mov ax, @data
    mov ds, ax

    ; Curata ecranul
    mov ah, 0   ; Seteaza modul video
    mov al, 3   ; Modul text 80x25
    int 10h

    ; Afiseaza titlul
    lea dx, msg_title_top
    call print_message
    lea dx, msg_title_inner
    call print_message
    lea dx, msg_title_bottom
    call print_message

    ; Afiseaza lista numerelor de inmatriculare cu zonele si costurile
    lea dx, msg_db
    call print_message

    ; Afiseaza dreptunghiurile pentru introducerea datelor
    lea dx, msg_input_top
    call print_message
    lea dx, msg_input_nr
    call print_message
    lea dx, msg_input_empty
    call print_message
    lea dx, msg_input_bottom
    call print_message

    ; Afiseaza caseta pentru verificare
    lea dx, msg_verif_box
    call print_message
    lea dx, msg_verif_line
    call print_message

    ; Seteaza cursorul pentru input
    mov dh, 13   ; Linia sub "Introdu nr. de inmatriculare"
    mov dl, 12   ; Coloana initiala pentru input
    call move_cursor

    ; Procesare intrare utilizator
    lea si, user_input
    call handle_input

    ; Termina programul
    mov ah, 4Ch
    int 21h
main endp

; Procedura pentru afisarea unui mesaj
print_message proc
    mov ah, 09h    ; Functia de afisare a sirului
    int 21h
    ret
print_message endp

; Procedura pentru mutarea cursorului
move_cursor proc
    mov ah, 02h
    mov bh, 0
    int 10h
    ret
move_cursor endp

; Procedura pentru gestionarea inputului utilizatorului
handle_input proc
    mov cx, 0 ; Lungimea curenta a inputului
    lea di, user_input
    mov dh, 13 ; Linia initiala pentru input
    mov dl, 12 ; Coloana initiala pentru input
input_loop:
    mov ah, 00h
    int 16h ; Asteapta tasta
    cmp al, 27 ; ESC pentru iesire
    je exit_program
    cmp al, 13 ; Daca Enter, finalizeaza
    je validate_input
    cmp al, 8 ; Daca Backspace
    je handle_backspace

    ; Converteste la litera mare daca este litera mica
    cmp al, 'a'
    jl skip_uppercase
    cmp al, 'z'
    jg skip_uppercase
    sub al, 20h ; Converteste la majuscula
skip_uppercase:

    ; Ignora spatiile
    cmp al, ' '
    je input_loop

    ; Adauga caracter in buffer daca nu a atins limita
    cmp cx, 7
    jge input_loop

    mov bx, di ; Folosim bx pentru indexare
    add bx, cx
    mov [bx], al
    inc cx

    ; Afiseaza caracterul
    mov ah, 0Eh
    int 10h
    inc dl ; Muta cursorul in dreapta
    call move_cursor
    jmp input_loop

handle_backspace:
    cmp cx, 0 ; Verifica daca sunt caractere de sters
    je input_loop
    dec cx ; Reduce lungimea inputului
    dec dl ; Muta cursorul inapoi
    call move_cursor
    mov ah, 0Eh
    mov al, ' ' ; Afiseaza spatiu pentru a sterge caracterul
    int 10h
    call move_cursor ; Revine la pozitia corecta
    jmp input_loop

validate_input:
    ; Verifica daca inputul este valid
    lea si, valid_numbers
validate_loop:
    lea di, user_input
    mov cx, 7
    repe cmpsb
    je input_valid
    add si, 8 ; Treci la urmatorul numar valid
    cmp byte ptr [si], 0 ; Verifica daca este sfarsitul listei
    jne validate_loop

    ; Daca nu s-a gasit, afiseaza "Invalid"
    mov dh, 15
    mov dl, 12
    call move_cursor
    lea dx, msg_invalid
    call print_message
    call clear_input
    jmp input_loop

input_valid:
    mov dh, 15
    mov dl, 12
    call move_cursor
    lea dx, msg_verified
    call print_message
    ret

clear_input:
    ; Sterge inputul pentru urmatoarea intrare
    mov dh, 13
    mov dl, 12
    call move_cursor
    mov dx, offset clear_text
    mov ah, 09h
    int 21h
    mov dh, 13
    mov dl, 12
    call move_cursor
    mov cx, 7
    jmp handle_input

clear_loop:
    mov byte ptr [di], ' '
    inc di
    loop clear_loop
    ; Sterge textul din caseta de input
    mov dh, 13
    mov dl, 12
clear_screen_loop:
    mov ah, 0Eh
    mov al, ' '
    int 10h
    inc dl
    cmp dl, 19 ; Limita pentru caseta
    jl clear_screen_loop
    mov dh, 13
    mov dl, 12
    call move_cursor
    ret

exit_program:
    ret
handle_input endp

end main
