CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -I./src
CXXFLAGS = -Wall -Wextra -std=c++11 -I./src -I/usr/local/include
LDFLAGS = -L/usr/local/lib -lCppUTest -lCppUTestExt

SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build

# 只包含 logic.c
C_SOURCES = $(SRC_DIR)/logic.c
C_OBJS = $(BUILD_DIR)/logic.o

# 所有測試檔案
TEST_SOURCES = $(wildcard $(TEST_DIR)/*.cpp)
TARGET = $(BUILD_DIR)/run_tests

.PHONY: all run clean

all: $(TARGET)

# 編譯 C source
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# 建立 build 目錄
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# 編譯並連結測試
$(TARGET): $(TEST_SOURCES) $(C_OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

test:  $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)

