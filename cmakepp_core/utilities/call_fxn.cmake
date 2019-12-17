include_guard()
include(cmakepp_core/utilities/unique_id)

#[[[ Performs most of the work for dynamically calling a function.
#
# ``cpp_call_fxn`` is a macro to avoid needing to forward returns. In
# order to actually call the function we need to write the call to disk. This
# involves setting a few variables, so in order to avoid contaminating the
# caller's namespace we wrap this part of ``cpp_call_fxn`` in this
# function, ``_cpp_call_fxn_guts``. ``_cpp_call_fxn_guts`` is not intended to be
# called from outside of ``cpp_call_fxn``.
#
# :param _cfg_fxn2call: The name of the function we are calling.
# :type _cfg_fxn2call: desc
# :param *args: The arguments to forward to the function.
#]]
function(_cpp_call_fxn_guts _cfg_fxn2call)
    cpp_unique_id(_cfg_uuid)
    set(_cfg_file "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxn_calls")
    set(_cfg_file "${_cfg_file}/${_cfg_fxn2call}_${_cfg_uuid}.cmake")
    file(WRITE "${_cfg_file}" "${_cfg_fxn2call}(${ARGN})")
    set("${_cfg_fxn2call}" "${_cfg_file}" PARENT_SCOPE)
endfunction()

#[[[ Calls a function who's name is provided at runtime.
#
# CMake does not allow you to dynamically determine the name of a function. For
# example one can NOT do ``${name_of_fxn}(<args...>)`` or any other variation
# which retrieves part of the function's name from a variable. The ``cpp_call``
# macro allows us to circumvent this limitation at the cost of some I/O.
#
# :param _ccf_fxn2call: The name of the function to call.
# :type _ccf_fxn2call: desc
# :param *args: The arguments to forward to the function.
#
# .. note::
#
#    ``cpp_call_fxn`` is a macro to avoid creating a new scope. If a new scope
#    was created it would be necessary to forward returns, which would
#    signifiantly complicate the implementation.
#]]
macro(cpp_call_fxn _cf_fxn2call)
    _cpp_call_fxn_guts("${_cf_fxn2call}" ${ARGN})
    include("${${_cf_fxn2call}}")
endmacro()
