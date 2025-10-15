/* Example linker script for M7 core (flash placement) */
MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1024K
    RAM (xrw)  : ORIGIN = 0x24000000, LENGTH = 512K
}

SECTIONS
{
    /* ... standard STM32 sections ... */
}