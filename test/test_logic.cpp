#include <stdio.h>

extern "C" {
    #include "../src/sensor.h"
    #include "../src/logic.h"
}

#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"
#include "CppUTest/CommandLineTestRunner.h"

// 🔁 模擬 C 函式
extern "C" int read_sensor_value(void) {
    return mock().actualCall("read_sensor_value").returnIntValueOrDefault(0);
}

TEST_GROUP(SensorLogic) {
    void teardown() {
        mock().clear();
    }
};

TEST(SensorLogic, SensorAboveThreshold) {
    mock().expectOneCall("read_sensor_value").andReturnValue(42);
    CHECK_EQUAL(1, process_sensor());
}

TEST(SensorLogic, SensorBelowThreshold) {
    mock().expectOneCall("read_sensor_value").andReturnValue(10);
    CHECK_EQUAL(0, process_sensor());
}

int main(int argc, char** argv)
{
    return CommandLineTestRunner::RunAllTests(argc, argv);
}
