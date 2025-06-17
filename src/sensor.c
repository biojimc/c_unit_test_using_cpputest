#include "sensor.h"

int process_sensor(void) {
    int value = get_sensor_value();
    if (value > 50) {
        return 1;  // OK
    } else {
        return 0;  // TOO LOW
    }
}
