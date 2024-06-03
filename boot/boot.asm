BITS 16

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Load the kernel
    mov bx, 0x1000
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    int 0x13

    jc disk_error
    jmp 0x1000:0

disk_error:
    mov si, disk_error_msg
    call print_string
    cli
    hlt

print_string:
    mov ah, 0x0E
    xor bx, bx
    .print_loop:
        lodsb
        cmp al, 0
        je .done
        int 0x10
        jmp .print_loop
    .done:
    ret

KERNEL_LOAD_ADDR equ 0x1000
disk_error_msg db "Error loading kernel from disk", 0

times 510-($-$$) db 0
dw 0xAA55
