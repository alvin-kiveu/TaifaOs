void kernel_main() {
    const char *str = "Welcome to TaifaOS";
    char *video_memory = (char *) 0xB8000;

    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07; // Light grey on black background
    }

    while (1) {
        // Halt CPU
        asm("hlt");
    }
}
