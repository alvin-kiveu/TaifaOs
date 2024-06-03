#include <stddef.h>

#define SCREEN_WIDTH  80
#define SCREEN_HEIGHT 25
#define VIDEO_MEMORY  0xb8000

void main(void) {
    const char *str = "Welcome to TaifaOS!";
    volatile unsigned short *vidptr = (unsigned short*)VIDEO_MEMORY;
    size_t i = 0;

    // Clear screen
    for (size_t j = 0; j < SCREEN_WIDTH * SCREEN_HEIGHT; ++j) {
        vidptr[j] = ' ' | (0x07 << 8);
    }

    // Write string to video memory
    for (; str[i] != '\0'; ++i) {
        vidptr[i] = str[i] | (0x07 << 8);
    }
}
