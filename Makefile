CC := arm-none-eabi-gcc
CFLAGS := -mcpu=cortex-m4 -mthumb -std=c11 -g -O0 
LDFLAGS :=  --specs=nosys.specs -nostartfiles -T stm32f4.ld

TARGET := main.elf

CFILES := main.c startup_stm32f4_c.c

# CFILES := main.c 
# ASFILES := startup_stm32f4.s

OBJFILES := $(CFILES:.c=.o) $(ASFILES:.s=.o) 


all: $(TARGET)

$(TARGET): $(OBJFILES)
	@printf "Linking $^ --> $@\n"
	@$(CC) $(LDFLAGS) $^ -o $@

%.o:%.s
	@printf "Compiling $^ --> $@\n"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $^ -o $@
	
%.o:%.c
	@printf "Compiling $^ --> $@\n"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $^ -o $@




.PHONY: clean
clean:
	rm -rf $(TARGET) $(OBJFILES)

.PHONY: inspect
inspect:
	@arm-none-eabi-objdump -d $(TARGET)
