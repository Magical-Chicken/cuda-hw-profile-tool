TARGET  = view-info
NVCC 	= nvcc
NVFLAGS =

HEADERS = $(shell find . -name '*.h')
NVOBJ 	= $(shell find . -name '*.cu' | sed -e 's/\.cu/\.o/')


all: $(TARGET)
	@:

$(TARGET): $(NVOBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.cu $(HEADERS)
	$(NVCC) $(NVFLAGS) -c -o $@ $<

clean:
	rm -rf *.o $(TARGET)

.PHONY: all clean
