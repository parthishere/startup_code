MEMORY
{
    flash (rx) : ORIGIN = 0x08000000, LENGTH = 512K
    ram (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}

_eram = ORIGIN(ram) + LENGTH(ram);
_stack = _eram;    /* stack grows backwards; */

SECTIONS 
{
    .text : ALIGN(4)
    {
        KEEP(*(.ivt))
        *(.text*)
        . = ALIGN(4);
        PROVIDE(_etext = .);
    } > flash

      /* Initial (constant) values for data is placed in flash after the program code */
     _idata = LOADADDR(.data);

    .data : ALIGN(4){
        PROVIDE(_sdata = .);
        *(.data*)
        = ALIGN(4);
        PROVIDE(_edata = .);
    } > ram AT > flash

    .bss : ALIGN(4) /*holds uninitialized global, and static data*/
    {
        PROVIDE(_sbss = .);
        *(.bss*)
        . = ALIGN(4);
        PROVIDE(_ebss = .);
    } > ram
}
