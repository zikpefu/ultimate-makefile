#Makefile for c files, to chnage to cpp files change gcc to g++ and change .c to .cpp


# Config
CC=gcc
CFLAGS=-Wall
LFLAGS=-lm -lc
OPTIMIZE = -O4
TARGET=triangles


# Generate source and object lists
C_SRCS := 	\
	$(wildcard *.c) \
	$(wildcard src/*.c) \
	$(wildcard src/**/*.c)
HDRS := \
	$(wildcard *.h) \
	$(wildcard src/*.h) \
	$(wildcard src/**/*.h)

OBJS := $(patsubst %.c, bin/%.o, $(wildcard *.c))
OBJS += $(filter %.o, $(patsubst src/%.c, bin/%.o, $(C_SRCS)))
all: build
	@echo "All Done"
# Link all built objects
build: $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(LFLAGS) $(OPTIMIZE)

# Catch root directory src files
bin/%.o: %.c $(HDRS)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(OPTIMIZE) -c $< -o $@

# Catch all nested directory files
bin/%.o: src/%.c $(HDRS)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(OPTIMIZE) -c $< -o $@
clean:
	rm -f $(TARGET)
	rm -rf bin

run: build
	./$(TARGET) airplane.ply
which:
	@echo "FOUND SOURCES: ${C_SRCS}"
	@echo "FOUND HEADERS: ${HDRS}"
	@echo "TARGET OBJS: ${OBJS}"
