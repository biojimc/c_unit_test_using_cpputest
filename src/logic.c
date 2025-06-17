// src/logic.c
#include "sensor.h"

int process_sensor(void) {
    int val = read_sensor_value();
    return (val > 30) ? 1 : 0;
}

