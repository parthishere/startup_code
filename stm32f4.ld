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
        _etext = .;
    } > flash
}