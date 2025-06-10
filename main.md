arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -std=c11 -g -O0 -c  main.c -o main.o
arm-none-eabi-gcc --specs=nosys.specs -nostartfiles  main.o -o main.elf
arm-none-eabi-gcc --specs=nosys.specs -nostartfiles -T stm32f4.ld main.o startup_stm32f4.o -o main.elf
arm-none-eabi-objdump -d main.elf
arm-none-eabi-size main.elf
