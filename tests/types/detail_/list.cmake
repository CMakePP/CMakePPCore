include(cmake_test/cmake_test)

ct_add_test("cpp_is_list")
    include(cmakepp_core/types/detail_/list)

    ct_add_section("array")
        include(cmakepp_core/array/detail_/ctor)
        _cpp_array_ctor(my_array)
        _cpp_is_list(result "${my_array}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("bool")
        _cpp_is_list(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("descriptions")
        ct_add_section("description w/o a list")
            _cpp_is_list(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing escaped semicolons")
            _cpp_is_list(return "Hello World 1\\\;2\\\;3")
            ct_assert_equal(return FALSE)
        ct_end_section()

    ct_end_section()

    ct_add_section("filepath")
        ct_add_section("Normal filepath (probably)")
            _cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Contains a semicolon (please don't do this either)")
            _cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}/hello\\\;world")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        _cpp_is_list(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        _cpp_is_list(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            _cpp_is_list(return "1;2;3")
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("List of lists")
            _cpp_is_list(return "TRUE\\\;FALSE;FALSE\\\;TRUE")
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/detail_/ctor)
        _cpp_map_ctor(my_map)
        _cpp_is_list(result "${my_map}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        _cpp_is_list(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("type")
        _cpp_is_list(return bool)
        ct_assert_equal(return FALSE)
    ct_end_section()
ct_end_test()
