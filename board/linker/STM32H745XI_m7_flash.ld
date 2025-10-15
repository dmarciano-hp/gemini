/* Linker script for STM32H745XI M7 core
 * FLASH and RAM mapping for Cortex-M7 domain
 * M7 core uses Bank 1 FLASH and D1/AXI SRAM domains
 */

MEMORY
{
  FLASH_M7 (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K  /* M7 core uses Bank 1 FLASH */
  DTCM     (xrw) : ORIGIN = 0x20000000, LENGTH = 128K   /* Data Tightly Coupled Memory */
  RAM_D1   (xrw) : ORIGIN = 0x24000000, LENGTH = 512K   /* D1 domain AXI SRAM */
  ITCM     (xrw) : ORIGIN = 0x00000000, LENGTH = 64K    /* Instruction Tightly Coupled Memory */
  RAM_D2   (xrw) : ORIGIN = 0x30000000, LENGTH = 288K   /* D2 domain SRAM1/2/3 (shared with M4) */
  RAM_D3   (xrw) : ORIGIN = 0x38000000, LENGTH = 64K    /* D3 domain SRAM4 (shared with M4) */
}

ENTRY(Reset_Handler)

/* Highest address of the user mode stack */
_estack = ORIGIN(DTCM) + LENGTH(DTCM);    /* end of DTCM RAM */

/* Generate a link error if heap and stack don't fit into RAM */
_Min_Heap_Size = 0x200;      /* required amount of heap  */
_Min_Stack_Size = 0x400;     /* required amount of stack */

SECTIONS
{
  /* Vector table and startup code in FLASH */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } >FLASH_M7

  /* Program code and other data in FLASH */
  .text :
  {
    . = ALIGN(4);
    *(.text)           /* .text sections (code) */
    *(.text*)          /* .text* sections (code) */
    *(.glue_7)         /* glue arm to thumb code */
    *(.glue_7t)        /* glue thumb to arm code */
    *(.eh_frame)

    KEEP (*(.init))
    KEEP (*(.fini))

    . = ALIGN(4);
    _etext = .;        /* define a global symbols at end of code */
  } >FLASH_M7

  /* Constant data in FLASH */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)         /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
    . = ALIGN(4);
  } >FLASH_M7

  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH_M7
  .ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >FLASH_M7

  .preinit_array     :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } >FLASH_M7

  .init_array :
  {
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
  } >FLASH_M7

  .fini_array :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } >FLASH_M7

  /* Used by the startup to initialize data */
  _sidata = LOADADDR(.data);

  /* Initialized data sections in DTCM RAM, load LMA copy after code */
  .data :
  {
    . = ALIGN(4);
    _sdata = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */
    *(.RamFunc)        /* .RamFunc sections */

    . = ALIGN(4);
    _edata = .;        /* define a global symbol at data end */
  } >DTCM AT> FLASH_M7

  /* Uninitialized data section in DTCM RAM */
  . = ALIGN(4);
  .bss :
  {
    /* This is used by the startup in order to initialize the .bss secion */
    _sbss = .;         /* define a global symbol at bss start */
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)

    . = ALIGN(4);
    _ebss = .;         /* define a global symbol at bss end */
    __bss_end__ = _ebss;
  } >DTCM

  /* User_heap_stack section, used to check that there is enough RAM left */
  ._user_heap_stack :
  {
    . = ALIGN(8);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } >DTCM

  /* Fast execution code can be placed in ITCM */
  .itcm_text :
  {
    . = ALIGN(4);
    *(.itcm_text)      /* Functions to be executed from ITCM */
    *(.itcm_text*)
    . = ALIGN(4);
  } >ITCM AT> FLASH_M7

  /* Large data buffers can be placed in AXI SRAM (D1 domain) */
  .axi_sram (NOLOAD) :
  {
    . = ALIGN(4);
    *(.axi_sram)       /* Large buffers in AXI SRAM */
    *(.axi_sram*)
    . = ALIGN(4);
  } >RAM_D1

  /* Shared data with M4 core can be placed in D2 domain */
  .d2_sram (NOLOAD) :
  {
    . = ALIGN(4);
    *(.d2_sram)        /* Shared data with M4 */
    *(.d2_sram*)
    . = ALIGN(4);
  } >RAM_D2

  /* Peripheral data in D3 domain (always powered) */
  .d3_sram (NOLOAD) :
  {
    . = ALIGN(4);
    *(.d3_sram)        /* Backup/peripheral data */
    *(.d3_sram*)
    . = ALIGN(4);
  } >RAM_D3

  /* Remove information from the standard libraries */
  /DISCARD/ :
  {
    libc.a ( * )
    libm.a ( * )
    libgcc.a ( * )
  }

  .ARM.attributes 0 : { *(.ARM.attributes) }
}