CPP = gcc
CPPFLAGS = -std=gnu11 -Wall -Wextra -Wpedantic
NVCC = nvcc
NVFLAGS = -Xcompiler '-fPIC'

HEADERS = $(shell find . -name '*.h')
NVOBJ = $(shell find . -name '*.cu' | sed -e 's/\.cu/\.o/')

CUDA_L64 = -L/opt/cuda-8.0/lib64

TARGET_SO = cuda-hw-profile-tool.so


all: $(CUDA_SO) view-data
	@:

view-data: view-data.o $(TARGET_SO)
	$(CC) $(CFLAGS) -o $@ $^

$(TARGET_SO): $(NVOBJ)
	$(NVCC) $(NVFLAGS) -dlink -o link.o $^
	$(CPP) -shared -o $@ $^ link.o $(CUDA_L64) -l cudart

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.cu $(HEADERS)
	$(NVCC) $(NVFLAGS) -dc -o $@ $<

clean:
	rm -rf *.o $(TARGET)

.PHONY: all clean
