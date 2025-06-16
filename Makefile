CC = gcc
CFLAGS = -Wall -Wextra -g -Isrc
LDFLAGS = -lcmocka

SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build

SRC_FILES = $(SRC_DIR)/sensor.c
TEST_FILES = $(TEST_DIR)/test_sensor.c

OBJS = $(BUILD_DIR)/sensor.o $(BUILD_DIR)/test_sensor.o
TARGET = $(BUILD_DIR)/test

.PHONY: all clean test

all: $(TARGET)

# 建立 build 目錄
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# 編譯測試執行檔
$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) -o $@ $^ $(LDFLAGS)

# 編譯 sensor.c
$(BUILD_DIR)/sensor.o: $(SRC_DIR)/sensor.c $(SRC_DIR)/sensor.h | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# 編譯 test_sensor.c 並定義 mock alias
$(BUILD_DIR)/test_sensor.o: $(TEST_DIR)/test_sensor.c $(SRC_DIR)/sensor.h | $(BUILD_DIR)
	$(CC) $(CFLAGS) -Dget_sensor_value=__wrap_get_sensor_value -c $< -o $@

# CI 用
test: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)
