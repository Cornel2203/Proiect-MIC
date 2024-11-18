name "Parcometru";test1

org 100h

.model small
.stack 100h
.data
msg_title db "Parcometru in functiune", 0
msg_cost db "Tarif: ", 0
msg_15min db "0.75 RON/15min", 0
msg_30min db "1.5 RON/30min", 0
msg_1hr db "3.0 RON/1 ora", 0

msg_locuri db "Locuri libere:", 0
msg_etaj1 db "Corp A, Etaj 1: 3 locuri", 0
msg_etaj2 db "Corp B, Etaj 1: 3 locuri", 0
msg_etaj3 db "Corp A, Etaj 2: 3 locuri", 0
msg_etaj4 db "Corp B, Etaj 2: 3 locuri", 0

msg_input_nrinmatriculare db "Nr. inmatriculare:", 0
msg_input_corp db "Selectati corpul/etajul:", 0
msg_input_durata db "Durata stationare:", 0

.code
main proc
    ; Initializare segmente
    mov ax, @data
    mov ds, ax
    mov ax, 0B800h
    mov es, ax
    
    ; Setare text de titlu
    mov di, 0 ; Pozitia pe ecran
    call print_title

    ; Afisare caseta costuri
    call print_cost

    ; Afisare caseta locuri libere
    call print_locuri_libere

    ; Afisare caseta informatii parcare
    call print_parcometru_info

    ; Terminare program
    mov ah, 4Ch
    int 21h
main endp

; Functie pentru afisare titlu
print_title proc
    mov cx, 25
    mov di, 0
    mov al, '-'
print_top:
    stosw
    loop print_top
    
    mov di, 160 ; 160 offset pentru randul urmator
    lea si, msg_title
    call print_string

    mov di, 320 ; Linie de delimitare sub titlu
    mov cx, 25
print_bottom:
    mov al, '-'
    stosw
    loop print_bottom
    ret
print_title endp

; Functie pentru afisare costuri
print_cost proc
    mov di, 500 ; Pozitie pe ecran
    lea si, msg_cost
    call print_string

    mov di, 660 ; A doua linie
    lea si, msg_15min
    call print_string

    mov di, 820 ; A treia linie
    lea si, msg_30min
    call print_string

    mov di, 980 ; A patra linie
    lea si, msg_1hr
    call print_string
    ret
print_cost endp

; Functie pentru afisare locuri libere
print_locuri_libere proc
    mov di, 1200 ; Pozitie pe ecran
    lea si, msg_locuri
    call print_string

    mov di, 1360
    lea si, msg_etaj1
    call print_string

    mov di, 1520
    lea si, msg_etaj2
    call print_string

    mov di, 1680
    lea si, msg_etaj3
    call print_string

    mov di, 1840
    lea si, msg_etaj4
    call print_string
    ret
print_locuri_libere endp

; Functie pentru afisare informatii parcare
print_parcometru_info proc
    mov di, 2400 ; Pozitie pentru numarul de inmatriculare
    lea si, msg_input_nrinmatriculare
    call print_string

    mov di, 2700 ; Pozitie pentru selectia corpului
    lea si, msg_input_corp
    call print_string

    mov di, 3000 ; Pozitie pentru durata
    lea si, msg_input_durata
    call print_string
    ret
print_parcometru_info endp

; Functie generala pentru afisare sir
print_string proc
    mov ah, 0Eh ; Setare culoare text
print_loop:
    lodsb
    or al, al
    jz print_string_end
    stosw
    jmp print_loop
print_string_end:
    ret
print_string endp

end main
