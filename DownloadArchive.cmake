
# Copyright 2023 Total Pave Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include(FetchContent)

function(DownloadArchive TARGET_NAME URL HASH)
    string(TOLOWER TARGET_NAME ${TARGET_NAME})
    cmake_path(GET URL FILENAME FILENAME)

    FetchContent_Declare(download_${TARGET_NAME}
        URL ${URL}
        URL_HASH SHA1=${HASH}
        DOWNLOAD_NO_EXTRACT true
        TLS_VERIFY true
    )
    FetchContent_MakeAvailable(download_${TARGET_NAME})

    set(SOURCE_DIR ${download_${TARGET_NAME}_SOURCE_DIR})

    file(ARCHIVE_EXTRACT INPUT ${SOURCE_DIR}/${FILENAME} DESTINATION ${CMAKE_BINARY_DIR}/${TARGET_NAME})

    set(${TARGET_NAME}_DownloadArchive download_${TARGET_NAME})
    set(${TARGET_NAME}_content_path ${CMAKE_BINARY_DIR}/${TARGET_NAME} PARENT_SCOPE)
endfunction()

# function(DownloadDependency TARGET_NAME DEP_URL DEP_SHA1)
#     string(FIND "${DEP_URL}" "/" DEP_FILENAME REVERSE)
#     set(DEP_FILE "${CMAKE_BINARY_DIR}/${DEP_FILE_NAME}")
#     set(EXTRACTION_DIR "${CMAKE_BINARY_DIR}/${TARGET_NAME}")

#     if(NOT EXISTS "${ZIP_FILE}" OR NOT EXISTS "${EXTRACTION_DIR}")
#         message(STATUS "Downloading and extracting ${TARGET_NAME}...")
        

#         FetchContent_Declare(download_${hash}
# URL ${url}
# URL_HASH SHA256=${hash}
# DOWNLOAD_NO_EXTRACT true
# TLS_VERIFY true
# )

#         # file(WRITE "${CMAKE_BINARY_DIR}/{TARGET_NAME}.sha1" "${DEP_SHA1}")
#         # file(DOWNLOAD ${DEP_URL} ${DEP_FILE} EXPECTED_HASH SHA1=${DEP_SHA1})


#     else()
#         message(STATUS "${TARGET_NAME} is already downloaded and extracted.")
#     endif()

# endfunction()

# function(download_and_extract_zip TARGET_NAME ZIP_URL ZIP_SHA1)
#     set(ZIP_FILE "${CMAKE_BINARY_DIR}/${TARGET_NAME}.zip")
#     set(EXTRACTION_DIR "${CMAKE_BINARY_DIR}/${TARGET_NAME}")

#     if(NOT EXISTS "${ZIP_FILE}" OR NOT EXISTS "${EXTRACTION_DIR}")
#         message(STATUS "Downloading and extracting ${TARGET_NAME}...")
#         file(DOWNLOAD ${ZIP_URL} ${ZIP_FILE} EXPECTED_HASH SHA1=${ZIP_SHA1})

#         execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${ZIP_FILE}
#                         WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

#         message(STATUS "${TARGET_NAME} downloaded and extracted.")
#     else()
#         message(STATUS "${TARGET_NAME} is already downloaded and extracted.")
#     endif()
# endfunction()
