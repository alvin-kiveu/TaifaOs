NASM=nasm
GCC=gcc
LD=ld
QEMU=qemu-system-i386

OBJDIR=obj
BINDIR=bin

all: $(BINDIR)/taifaos.img

$(BINDIR)/taifaos.img: $(BINDIR)/bootloader.bin $(BINDIR)/kernel.bin
    dd if=/dev/zero of=$@ bs=512 count=2880
    dd if=$(BINDIR)/bootloader.bin of=$@ conv=notrunc
    dd if=$(BINDIR)/kernel.bin of=$@ seek=1 conv=notrunc

$(BINDIR)/bootloader.bin: boot/boot.asm | $(BINDIR)
    $(NASM) -f bin $< -o $@

$(BINDIR)/kernel.bin: $(OBJDIR)/bootloader.o $(OBJDIR)/kernel.o | $(BINDIR)
    $(LD) -T linker.ld -o $@ $^

$(OBJDIR)/bootloader.o: boot/boot.asm | $(OBJDIR)
    $(NASM) -f elf $< -o $@

$(OBJDIR)/kernel.o: kernel/kernel.c | $(OBJDIR)
    $(GCC) -m32 -ffreestanding -c $< -o $@

$(OBJDIR):
    mkdir -p $(OBJDIR)

$(BINDIR):
    mkdir -p $(BINDIR)

clean:
    rm -rf $(OBJDIR) $(BINDIR)

run: $(BINDIR)/taifaos.img
    $(QEMU) -drive file=$<,format=raw

.PHONY: all run clean
