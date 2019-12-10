include(cmake_test/cmake_test)

ct_add_test("_cpp_array_as_list")
    include(cmakepp_core/array/detail_/as_list)
    include(cmakepp_core/array/detail_/ctor)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_array_ctor(an_array)

        ct_add_section("Arg1: must be desc")
            _cpp_array_as_list(TRUE "${an_array}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: must be an array")
            _cpp_array_as_list(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Takes 2 arguments")
            _cpp_array_as_list(result "${an_array}" hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Empty")
        _cpp_array_ctor(an_array)
        _cpp_array_as_list(result "${an_array}")
        if(NOT "${result}" STREQUAL [[]])
            message(FATAL_ERROR "Lists are not equal")
        endif()
    ct_end_section()

    ct_add_section("Single element")
        _cpp_array_ctor(an_array foo)
        _cpp_array_as_list(result "${an_array}")
        if(NOT "${result}" STREQUAL [[foo]])
            message(FATAL_ERROR "Lists are not equal")
        endif()
    ct_end_section()

    ct_add_section("Two elements")
        _cpp_array_ctor(an_array foo bar)
        _cpp_array_as_list(result "${an_array}")
        if(NOT "${result}" STREQUAL [[foo;bar]])
            message(FATAL_ERROR "Lists are not equal")
        endif()
    ct_end_section()

    ct_add_section("Three elements")
        _cpp_array_ctor(an_array foo bar 42)
        _cpp_array_as_list(result "${an_array}")
        if(NOT "${result}" STREQUAL [[foo;bar;42]])
            message(FATAL_ERROR "Lists are not equal")
        endif()
    ct_end_section()

    ct_add_section("Nested lists")
        _cpp_array_ctor(subarray 1 2 3)
        _cpp_array_ctor(an_array foo ${subarray} bar)
        _cpp_array_as_list(result "${an_array}")
        if(NOT "${result}" STREQUAL [[foo;1\;2\;3;bar]])
            message(FATAL_ERROR "${result} are not equal")
        endif()
    ct_end_section()

    ct_add_section("Nested, nested lists")
        _cpp_array_ctor(subsubarray 1 2 3)
        _cpp_array_ctor(subarray foo ${subsubarray} bar)
        _cpp_array_ctor(an_array "${subarray}" "${subarray}")
        _cpp_array_as_list(result "${an_array}")
        if(NOT "${result}" STREQUAL [[foo\;1\\;2\\;3\;bar;foo\;1\\;2\\;3\;bar]])
            message(FATAL_ERROR "${result} are not equal")
        endif()
    ct_end_section()
ct_end_test()