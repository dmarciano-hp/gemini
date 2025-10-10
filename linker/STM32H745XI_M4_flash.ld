/* Example linker script for M4 core (flash placement) */
MEMORY
{
    FLASH (rx) : ORIGIN = 0x08100000, LENGTH = 512K
    RAM (xrw)  : ORIGIN = 0x30000000, LENGTH = 288K
}

SECTIONS
{
    /* ... standard STM32 sections ... */
}