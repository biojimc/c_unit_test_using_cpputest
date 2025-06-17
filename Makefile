# 編譯器
CXX = g++
CXXFLAGS = -I/usr/local/include -std=c++11
LDFLAGS = -L/usr/local/lib -lCppUTest -lCppUTestExt

SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build


SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRCS))

TEST = $(TEST_DIR)/test_logic.cpp
TARGET = $(BUILD_DIR)/run_tests

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(TARGET): $(TEST) $(OBJS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

.PHONY: run clean
all: $(TARGET)

test: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)

