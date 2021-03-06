include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/get_meta_attr)
include(cmakepp_core/types/cmakepp_type)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/sanitize_string)

#[[[ Constructs a new instance of the specified type.
#
# This function constructs a new instance of the specified type. This should not
# be confused with creating a new, default initialized Object instance which is
# done with the ``_cpp_object_singleton`` function. The resulting instance will
# be initialized to the default state for the specified type.
#
# :param _oc_this: Name for the variable which will hold the resulting instance.
# :type _oc_this: desc
# :param _oc_type: The most-derived type of the object we are creating.
# :type _oc_type: type
# :param *args: The initial instances of each direct base class on which this
#               instance should be built.
# :return: ``_oc_this`` will be set to the newly created instance.
# :rtype: obj
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode (and only if CMakePP is being run in
# debug mode) this function will assert that it has been called with the correct
# number and types of arguments. If an assertion fails an error will be raised.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(_cpp_object_ctor _oc_this _oc_type)
    cpp_assert_signature("${ARGV}" desc type args)

    cpp_map(CTOR _oc_fxns)
    cpp_map(CTOR _oc_attrs)
    cpp_map(CTOR _oc_sub_objs)

    foreach(_oc_sub_obj_i ${ARGN})
        _cpp_object_get_meta_attr("${_oc_sub_obj_i}" _oc_type_i "my_type")
        cpp_map(SET "${_oc_sub_objs}" "${_oc_type_i}" "${_oc_sub_obj_i}")
    endforeach()

    cpp_sanitize_string(_oc_type "${_oc_type}")
    cpp_map(CTOR _oc_state  _cpp_attrs "${_oc_attrs}"
                            _cpp_fxns "${_oc_fxns}"
                            _cpp_sub_objs "${_oc_sub_objs}"
                            _cpp_my_type "${_oc_type}"
    )

    cpp_unique_id("${_oc_this}")
    cpp_set_global("${${_oc_this}}__state" "${_oc_state}")
    _cpp_set_cmakepp_type("${${_oc_this}}" "${_oc_type}")
    cpp_return("${_oc_this}")
endfunction()
