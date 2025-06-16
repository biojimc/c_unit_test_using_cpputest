CC = gcc
CFLAGS = -Wall -Itest

SRC = src/math.c
TEST_SRC = test/test_math.c test/unity.c
TARGET = test_runner

.PHONY: all clean test

all: $(TARGET)

$(TARGET): $(SRC) $(TEST_SRC)
	$(CC) $(CFLAGS) -o $@ $^

test: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
