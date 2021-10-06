#
# Copyright 2021, Unikie
#
# SPDX-License-Identifier: BSD-2-Clause
#

cmake_minimum_required(VERSION 3.7.2)

project(gen_hss_payload)

include(FetchContent)

set(PAYLOAD_TOOL_URL "https://github.com/polarfire-soc/hart-software-services/releases/download/2021.04/hss-payload-generator-0.99.16-linux-x86_64.tar.gz")

FetchContent_Declare(
  payload_tool
  URL ${PAYLOAD_TOOL_URL}
)
FetchContent_MakeAvailable(payload_tool)
set(PAYLOAD_TOOL_BIN "${payload_tool_SOURCE_DIR}/hss-payload-generator")

set(PAYLOAD_CONF "${CMAKE_CURRENT_SOURCE_DIR}/config.yaml")

get_property(root_image TARGET rootserver_image PROPERTY IMAGE_NAME)
set(ROOTSERVER_BIN "${CMAKE_BINARY_DIR}/${root_image}")
set(SEL4_PAYLOAD "${CMAKE_CURRENT_BINARY_DIR}/sel4payload")

set(HSS_PAYLOAD_BIN "${CMAKE_CURRENT_BINARY_DIR}/payload.bin")

add_custom_command(
    OUTPUT "${HSS_PAYLOAD_BIN}"
    COMMENT "Creating ${HSS_PAYLOAD_BIN}"

    COMMAND cp ${ROOTSERVER_BIN} ${SEL4_PAYLOAD}
    COMMAND ${PAYLOAD_TOOL_BIN} -c ${PAYLOAD_CONF} -vvv ${HSS_PAYLOAD_BIN}

    VERBATIM
)

add_custom_target(hss_payload_bin ALL
    DEPENDS
        ${PAYLOAD_TOOL_BIN}
        ${ROOTSERVER_BIN}
        ${HSS_PAYLOAD_BIN}
    VERBATIM
)

add_dependencies(hss_payload_bin
                    rootserver_image)
