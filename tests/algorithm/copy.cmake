include(cmake_test/cmake_test)

ct_add_test("cpp_copy")
    include(cmakepp_core/algorithm/copy)
    include(cmakepp_core/algorithm/equal)

    ct_add_section("array")
        include(cmakepp_core/array/array)
        cpp_array(CTOR lhs 1 2 3)
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("bool")
        set(lhs TRUE)
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("descriptions")
        set(lhs "hello world")
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("floats")
        set(lhs 3.14)
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("ints")
        set(lhs 42)
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("lists")
        set(lhs "hello;world")
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR lhs a_key a_value foo bar)
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("types")
        set(lhs int)
        cpp_copy(rhs "${lhs}")
        cpp_equal(result "${lhs}" "${rhs}")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()