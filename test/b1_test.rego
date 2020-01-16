package a_test

import data.a

test_allow {
    a.x == 0
    a.y == 1
    a.allow with input as {"x": 0, "y": 1}
}

benchmark_allow {
    test_allow
}

benchmark_allow_5 {
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
}

benchmark_allow_20 {
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
    test_allow
}