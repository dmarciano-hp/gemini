/* Sample linker script for STM32H745 M4 core
 * FLASH and RAM mapping for Cortex-M4 domain
 * Adjust memory sizes for your exact part!
 */

MEMORY
{
  FLASH_M4 (rx)  : ORIGIN = 0x08100000, LENGTH = 1024K  /* M4 core uses Bank 2 FLASH */
  RAM_D2   (xrw) : ORIGIN = 0x30000000, LENGTH = 288K   /* D2 domain RAM */
  RAM_D3   (xrw) : ORIGIN = 0x38000000, LENGTH = 64K    /* D3 domain RAM */
}

ENTRY(Reset_Handler)

SECTIONS
{
  /* Vector table and startup in FLASH */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } >FLASH_M4

  /* Code and constants in FLASH */
  .text :
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
    KEEP(*(.init))
    KEEP(*(.fini))
    . = ALIGN(4);
  } >FLASH_M4

  /* ARM EH/Unwind sections */
  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH_M4
  .ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >FLASH_M4

  .eh_frame_hdr : { *(.eh_frame_hdr) } >FLASH_M4
  .eh_frame     : { KEEP(*(.eh_frame)) } >FLASH_M4

  /* Initialized data in RAM_D2 */
  .data : 
  {
    . = ALIGN(4);
    _sidata = LOADADDR(.data);
    _sdata = .;
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >RAM_D2 AT > FLASH_M4

  /* Uninitialized data in RAM_D2 */
  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;
  } >RAM_D2

  /* Stack in RAM_D2 */
  ._user_stack :
  {
    . = ALIGN(8);
    _sstack = .;
    . = . + 0x1000; /* 4K stack */
    _estack = .;
  } >RAM_D2

  /* Heap in RAM_D2 */
  .heap (NOLOAD) :
  {
    . = ALIGN(8);
    _heap_start = .;
    . = . + 0x1000; /* 4K heap */
    _heap_end = .;
  } >RAM_D2

  /* Remove unused sections */
  /DISCARD/ : { *(.note.GNU-stack) }

  /* End symbol */
  _end = .;
}