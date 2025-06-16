#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>

#include "sensor.h"

// 用 mock 取代原本的 get_sensor_value()
int __wrap_get_sensor_value(void) {
    return mock_type(int);
}

static void test_sensor_high(void **state) {
    (void) state;
    will_return(__wrap_get_sensor_value, 60);  // 模擬回傳高值
    assert_int_equal(process_sensor(), 1);
}

static void test_sensor_low(void **state) {
    (void) state;
    will_return(__wrap_get_sensor_value, 20);  // 模擬回傳低值
    assert_int_equal(process_sensor(), 0);
}

int main(void) {
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_sensor_high),
        cmocka_unit_test(test_sensor_low),
    };

    return cmocka_run_group_tests(tests, NULL, NULL);
}
