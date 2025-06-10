extern int main(void);

// symbol defined in linker script
extern unsigned int _stack;


void isr_reset(void) {
    main();

    while(1);
}

void isr_hardfault(void){
    while(1);
}


#define IVT_ARRAY_SIZE 48
typedef void (*isr_t)(void);
__attribute((used, section(".ivt")))
static const isr_t ivt[IVT_ARRAY_SIZE] = {
    (isr_t)&_stack,
    isr_reset,
    0,
    isr_hardfault,

    // incomplete table, defults to 0
};