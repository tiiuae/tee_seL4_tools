#
# Copyright 2021, Unikie
#
# SPDX-License-Identifier: BSD-2-Clause
#

set(GEN_HSS_PAYLOAD_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE STRING "")
mark_as_advanced(GEN_HSS_PAYLOAD_DIR)

function(gen_hss_payload_import_project)
    add_subdirectory(${GEN_HSS_PAYLOAD_DIR} gen_hss_payload)
endfunction()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(gen_hss_payload DEFAULT_MSG GEN_HSS_PAYLOAD_DIR)
