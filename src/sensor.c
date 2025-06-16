#include "sensor.h"

int get_sensor_value(void) {
    // 模擬從某硬體讀感測器數值
    return 42;
}

int process_sensor(void) {
    int value = get_sensor_value();
    if (value > 50) {
        return 1;  // OK
    } else {
        return 0;  // TOO LOW
    }
}
