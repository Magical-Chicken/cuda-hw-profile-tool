CPP = gcc
CPPFLAGS = -std=gnu++11 -Wall -Wextra -Wpedantic
NVCC = nvcc
NVFLAGS = -Xcompiler '-fPIC'

HEADERS = $(shell find . -name '*.h')
CPPOBJ = $(shell find . -name '*.cpp' | sed -e 's/\.cpp/\.o/')
NVOBJ = $(shell find . -name '*.cu' | sed -e 's/\.cu/\.o/')

CUDA_L64 = -L/opt/cuda-8.0/lib64

TARGET_SO = cuda-hw-profile-tool.so
TARGET_PROG = view-data


all: $(TARGET_SO) $(TARGET_PROG)
	@:

$(TARGET_PROG): view-data.o $(TARGET_SO)
	$(CC) $(CFLAGS) -o $@ $^

$(TARGET_SO): $(NVOBJ)
	$(NVCC) $(NVFLAGS) -dlink -o link.o $^
	$(CPP) -shared -o $@ $^ link.o $(CUDA_L64) -l cudart

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.cu $(HEADERS)
	$(NVCC) $(NVFLAGS) -dc -o $@ $<

clean:
	rm -rf *.o $(TARGET_SO) $(TARGET_PROG)

.PHONY: all clean
