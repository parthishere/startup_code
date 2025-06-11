extern int main(void);
extern void __libc_init_array(void);

// symbol defined in linker script
extern unsigned int _stack;
extern unsigned int _idata;
extern unsigned int _sdata;
extern unsigned int _edata;
extern unsigned int _sbss;
extern unsigned int _ebss;


void zero_bss_seg(void){
    unsigned int *bss_ptr = &_sbss;
    while(bss_ptr < &_ebss){
        *bss_ptr++ = 0;
    }
}

void copy_data_seg(void){
    unsigned int *src_data_ptr = &_idata;
    unsigned int *dst_data_ptr = &_sdata;
    while(dst_data_ptr < &_edata){
        *dst_data_ptr++ = *src_data_ptr++;
    }
}

// Normally provided by Newlib's runtime file crti.o, but we compile without
// (-startfiles) Inserted by __libc_init_array because newlib was compiled with
// _HAVE_INIT_FINI. We don't need it, so add an empty stub.
void _init(void) {}

void isr_reset(void) {
    // You may implement system_init to perform additional early hardware
    // initialization depending on system requirements. This may include
    // configuring clocks, setting up memory or other peripherals, working
    // around hardware errata, and so on.
    // system_init();
    copy_data_seg();
    zero_bss_seg();
    __libc_init_array();
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
