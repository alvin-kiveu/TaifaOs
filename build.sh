#!/bin/bash

# Assemble bootloader
nasm -f bin -o boot.bin boot.asm

# Compile kernel
gcc -m32 -ffreestanding -c kernel.c -o kernel.o

# Link kernel
ld -m elf_i386 -Ttext 0x1000 --oformat binary kernel.o -o kernel.bin

# Create OS image
cat boot.bin kernel.bin > taifaos.img

echo "Build complete. Bootable image: taifaos.img"
