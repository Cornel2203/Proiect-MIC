
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.MODEL SMALL
.STACK 100H
.DATA
    prompt1 db 'Select a drink: 1-Coffee, 2-Tea, 3-Other$'
    prompt2 db 'Enter sugar level (0-5): $'
    unavailable db 'Sorry, this drink is unavailable.$'
    coffee_ready db 'Your coffee is ready! $'
    tea_ready db 'Your tea is ready! $'
    other_ready db 'Your drink is ready! $'
    sugar_prompt db 'Sugar level: $'
    invalid_option db 'Invalid selection!$'
    
.CODE
.STARTUP

; Display the drink selection prompt
    MOV AH, 09H
    LEA DX, prompt1
    INT 21H

; Read user input (1 for coffee, 2 for tea, 3 for other)
    MOV AH, 01H
    INT 21H
    SUB AL, '0'    ; Convert from ASCII to number

; Store the selected option
    MOV BL, AL

; Ask for sugar level
    MOV AH, 09H
    LEA DX, prompt2
    INT 21H

; Read sugar level input (0-5)
    MOV AH, 01H
    INT 21H
    SUB AL, '0'    ; Convert from ASCII to number
    CMP AL, 5
    JA invalid_input ; If sugar level > 5, go to invalid input

; Display the selected sugar level
    MOV AH, 09H
    LEA DX, sugar_prompt
    INT 21H

    MOV AH, 02H
    MOV DL, AL     ; Show the sugar level entered
    ADD DL, '0'    ; Convert back to ASCII
    INT 21H

; Process drink selection
    CMP BL, 1
    JE coffee_section
    CMP BL, 2
    JE tea_section
    CMP BL, 3
    JE other_section

; Invalid option if not 1, 2, or 3
    JMP invalid_input

coffee_section:
    ; Display Coffee ready message
    MOV AH, 09H
    LEA DX, coffee_ready
    INT 21H
    JMP end_program

tea_section:
    ; Display Tea ready message
    MOV AH, 09H
    LEA DX, tea_ready
    INT 21H
    JMP end_program

other_section:
    ; Check if other drink is available
    ; Let's assume this drink is unavailable for now
    MOV AH, 09H
    LEA DX, unavailable
    INT 21H
    JMP end_program

invalid_input:
    ; Display invalid option message
    MOV AH, 09H
    LEA DX, invalid_option
    INT 21H

end_program:
    MOV AH, 4CH   ; Terminate the program
    INT 21H

END

ret




