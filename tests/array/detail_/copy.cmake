include(cmake_test/cmake_test)

ct_add_test("_cpp_array_copy")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/array/array)
    cpp_array(CTOR an_array 1 2 3)

    ct_add_section("Different instances")
        _cpp_array_copy(a_copy "${an_array}")
        if("${a_copy}" STREQUAL "${an_array}")
            message(FATAL_ERROR "Are the same instance")
        endif()
    ct_end_section()

    ct_add_section("Are the same value")
        _cpp_array_copy(a_copy "${an_array}")
        cpp_equal(result "${a_copy}" "${an_array}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Are not coupled")
        _cpp_array_copy(a_copy "${an_array}")
        cpp_array(SET "${an_array}" 0 3)
        cpp_equal(result "${a_copy}" "${an_array}")
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
