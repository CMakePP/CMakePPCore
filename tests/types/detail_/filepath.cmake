include(cmake_test/cmake_test)

ct_add_test("_cpp_is_filepath")
    include(cmakepp_core/types/detail_/filepath)

    ct_add_section("array")
        include(cmakepp_core/array/detail_/ctor)
        _cpp_array_ctor(my_array)
        _cpp_is_filepath(result "${my_array}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("bool")
        _cpp_is_filepath(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("description")
        ct_add_section("Empty description")
            _cpp_is_filepath(return "")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Normal description")
            _cpp_is_filepath(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Description with a filepath in it")
            _cpp_is_filepath(return "The path is: ${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("filepath")
        ct_add_section("absolute")
            _cpp_is_filepath(return "${CMAKE_BINARY_DIR}")
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("relative")
            _cpp_is_filepath(return "a/directory")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        _cpp_is_filepath(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        _cpp_is_filepath(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            set(a_list 1 2 3)
            _cpp_is_filepath(return "${a_list}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("List of filepaths")
            set(a_list ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_CURRENT_LIST_DIR})
            _cpp_is_filepath(return "${a_list}")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/detail_/ctor)
        _cpp_map_ctor(my_map)
        _cpp_is_filepath(result "${my_map}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        _cpp_is_filepath(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("type")
        _cpp_is_filepath(return bool)
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()
