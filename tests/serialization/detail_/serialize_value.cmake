include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_value")
    include(cmakepp_core/serialization/detail_/serialize_value)

    ct_add_section("bool")
        _cpp_serialize_string(result TRUE)
        ct_assert_equal(result [["TRUE"]])
    ct_end_section()

    ct_add_section("filepath")
        _cpp_serialize_string(result "${CMAKE_CURRENT_BINARY_DIR}")
        ct_assert_equal(result "\"${CMAKE_CURRENT_BINARY_DIR}\"")
    ct_end_section()

    ct_add_section("float")
        _cpp_serialize_string(result 3.14)
        ct_assert_equal(result "\"3.14\"")
    ct_end_section()

    ct_add_section("int")
        _cpp_serialize_string(result 42)
        ct_assert_equal(result "\"42\"")
    ct_end_section()

    ct_add_section("list")
        _cpp_serialize_value(result [[hello;world]])
        ct_assert_equal(result "[ \"hello\" , \"world\" ]")
    ct_end_section()

    ct_add_section("obj")
        include(cmakepp_core/algorithm/contains)
        include(cmakepp_core/object/object)

        cpp_object(CTOR an_object)
        _cpp_serialize_value(result "${an_object}")
        set(corr "\"type\" : obj, \"attrs\" : { \"_cpp_bases\" : \"obj\", ")
        string(APPEND corr "\"_cpp_type\" : \"obj\", } }")
        cpp_contains(result "${corr}" "${result}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("type")
        _cpp_serialize_string(result int)
        ct_assert_equal(result "\"int\"")
    ct_end_section()
ct_end_test()
