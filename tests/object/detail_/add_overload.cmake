function(_cpp_object_add_overload _coao_type _coao_fxn)
    _cpp_object_get_overloads(_coao_overloads "${_coao_type}" "${_coao_fxn}")
    _cpp_mangle_fxn("${_coao_fxn}" "${_coao_fxn}" "${_coao_type}" ${ARGN})
    cpp_array(CTOR _coao_args ${ARGN})
    cpp_map(SET "${_coao_overloads}" "${_coao_args}" "${_coao_mn}")
    cpp_return("${_coao_fxn}")
endfunction()
