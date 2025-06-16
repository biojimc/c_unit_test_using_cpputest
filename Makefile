CC = gcc
CFLAGS = -Wall -Wextra -g
LDFLAGS = -lcmocka

TARGET = test
OBJS = sensor.o test_sensor.o

.PHONY: all clean test

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

sensor.o: sensor.c sensor.h
	$(CC) $(CFLAGS) -c sensor.c -o $@

test_sensor.o: test_sensor.c sensor.h
	$(CC) $(CFLAGS) -c test_sensor.c -Dget_sensor_value=__wrap_get_sensor_value -o $@

# ✅ 測試用 (for CI/CD)
test: $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o $(TARGET)
