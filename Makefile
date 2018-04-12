TARGET  = cuda-profiler
CC 		= gcc
CFLAGS 	= -std=gnu11 -Wall -Wextra -Wpedantic
NVCC 	= nvcc
NVFLAGS = -arch compute_62

HEADERS = $(shell find . -name '*.h')
COBJ 	= $(shell find . -name '*.c' | sed -e 's/\.c/\.o/')
NVOBJ 	= $(shell find . -name '*.cu' | sed -e 's/\.cu/\.o/')


all: $(TARGET)
	@:

$(TARGET): $(COBJ) $(NVOBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.cu $(HEADERS)
	$(NVCC) $(NVFLAGS) -c -o $@ $<

clean:
	rm -rf *.o $(TARGET)

.PHONY: all clean
