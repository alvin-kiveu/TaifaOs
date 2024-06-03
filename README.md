# TaifaOS

<p align="center">
  <img src="icon/icon_round.png" alt="TaifaOS Icon" width="200" height="200">
</p>

TaifaOS is a simple operating system that is written in C and Assembly. It is a 32-bit operating system that is designed to run on x86 architecture. The operating system is still in development and is not yet ready for use. The operating system is designed to be a simple operating system that can be used to learn about operating system development.



## Building the Operating System

To build the operating system, you will need to have the following tools installed on your system:

- QEMU : This is an open-source machine emulator and virtualizer that is used to run the operating system.

- NASM : This is an assembler that is used to assemble the assembly code.

- GCC : This is a compiler that is used to compile the C code.



To build the operating system, you will need to run the following command:


File structure:
```bash
TaifaOS/
│
├── boot/
│   └── boot.asm
│
├── kernel/
│   └── kernel.c
│
├── linker.ld
│
└── Makefile

```


How to build a TaifaOS image on Linux:
```bash
$ make
```

How to build a TaifaOS image on Windows:
```bash
dd if=/dev/zero of=taifaos.img bs=512 count=2880
```

How to run a TaifaOS image on Windows using QEMU:
```bash
qemu-system-i386 -drive file=taifaos.img,format=raw
```

How to generate a TaifaOS iso image on Linux:
```bash
$ make iso
```

How to run a TaifaOS iso image on Linux using QEMU:
```bash
dd if=/dev/zero of=taifaos.iso bs=512 count=2880
mkfs.vfat taifaos.iso
mkdir -p /mnt/iso
mount -o loop taifaos.iso /mnt/iso
cp taifaos.img /mnt/iso
umount /mnt/iso
qemu-system-i386 -cdrom taifaos.iso
```

How to run a TaifaOS image on Linux using QEMU:
```bash
$ qemu-system-i386 -drive file=taifaos.img,format=raw
```


This will run the operating system in QEMU.


## Contributing

If you would like to contribute to the development of TaifaOS, you can fork the repository and submit a pull request. You can also open an issue if you have any questions or suggestions.

