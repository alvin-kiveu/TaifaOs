[BITS 16]
[ORG 0x7C00]

start:
    cli             ; Clear interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00 ; Set stack pointer

    mov si, hello_msg
    call print_string

    hlt             ; Halt CPU

print_string:
    mov ah, 0x0E    ; BIOS teletype function
.next_char:
    lodsb           ; Load next character
    cmp al, 0
    je .done
    int 0x10        ; Print character
    jmp .next_char
.done:
    ret

hello_msg db 'Hello, TaifaOS!', 0

times 510-($-$$) db 0
dw 0xAA55         ; Boot signature
