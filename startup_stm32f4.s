.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb


.global isr_reset
.section .text.isr_reset 
.type isr_reset, %function
isr_reset:
    bl main // branch long main

    loop: b loop


.global isr_hardfault
.section .text.isr_hardfault
.type isr_hardfault, %function
isr_hardfault: b isr_hardfault


.equ IVT_ARRAY_SIZE, 48

.global ivt
.type ivt %object
.section .ivt 
ivt:
    .word _stack
    .word isr_reset
    .word 0
    .word isr_hardfault
    .fill (IVT_ARRAY_SIZE - 3), 1, 0
