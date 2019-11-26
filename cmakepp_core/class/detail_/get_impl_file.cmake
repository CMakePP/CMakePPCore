include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/assert_class_is_registered)
include(cmakepp_core/class/detail_/get_class_registry)
include(cmakepp_core/utilities/return)

function(_cpp_class_get_impl_file _ccgif_result _ccgif_type)
    cpp_assert_signature("${ARGV}" desc desc)
    _cpp_assert_class_is_registered("${_ccgif_type}")

    _cpp_get_class_registry(_ccgif_registry)
    cpp_map(GET _ccgif_class "${_ccgif_registry}" "${_ccgif_type}")
    cpp_map(GET "${_ccgif_result}" "${_ccgif_class}" impl_file)
    cpp_return("${_ccgif_result}")
endfunction()
