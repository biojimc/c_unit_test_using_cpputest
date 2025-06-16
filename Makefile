CC = gcc
CFLAGS = -Wall -Wextra -g -Isrc
# 增加 -Wl,--wrap=get_sensor_value 讓 linker 攔截 get_sensor_value 的呼叫
LDFLAGS = -lcmocka -Wl,--wrap=get_sensor_value

SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build

SRC_FILES = $(SRC_DIR)/sensor.c
TEST_FILES = $(TEST_DIR)/test_sensor.c

OBJS = $(BUILD_DIR)/sensor.o $(BUILD_DIR)/test_sensor.o
TARGET = $(BUILD_DIR)/test

.PHONY: all clean test

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) -o $@ $^ $(LDFLAGS)

$(BUILD_DIR)/sensor.o: $(SRC_DIR)/sensor.c $(SRC_DIR)/sensor.h | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/test_sensor.o: $(TEST_DIR)/test_sensor.c $(SRC_DIR)/sensor.h | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# CI 用的測試目標
test: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)
