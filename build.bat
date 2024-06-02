@echo off
setlocal

rem Paths to tools
set NASM=C:\path\to\nasm.exe
set GCC=C:\path\to\mingw32-gcc.exe
set LD=C:\path\to\mingw32-ld.exe
set QEMU=C:\Program Files\qemu\qemu-system-i386.exe

rem Check if NASM exists
if not exist "%NASM%" (
    echo NASM not found at %NASM%
    exit /b 1
)

rem Check if GCC exists
if not exist "%GCC%" (
    echo GCC not found at %GCC%
    exit /b 1
)

rem Check if LD exists
if not exist "%LD%" (
    echo LD not found at %LD%
    exit /b 1
)

rem Check if QEMU exists
if not exist "%QEMU%" (
    echo QEMU not found at %QEMU%
    exit /b 1
)

rem Assemble bootloader
%NASM% -f bin -o boot.bin boot.asm
if %errorlevel% neq 0 (
    echo NASM assembly failed
    exit /b 1
)

rem Compile kernel
%GCC% -m32 -ffreestanding -c kernel.c -o kernel.o
if %errorlevel% neq 0 (
    echo GCC compilation failed
    exit /b 1
)

rem Link kernel
%LD% -m elf_i386 -Ttext 0x1000 --oformat binary kernel.o -o kernel.bin
if %errorlevel% neq 0 (
    echo LD linking failed
    exit /b 1
)

rem Create OS image
copy /b boot.bin+kernel.bin taifaos.img
if %errorlevel% neq 0 (
    echo Failed to create OS image
    exit /b 1
)

echo Build complete. Bootable image: taifaos.img

rem Run the OS image in QEMU
%QEMU% -drive format=raw,file=taifaos.img

endlocal
