
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

    # set(${TARGET_NAME}_DownloadArchive download_${TARGET_NAME} PARENT_SCOPE)
    set(${TARGET_NAME}_content_path ${CMAKE_BINARY_DIR}/${TARGET_NAME} PARENT_SCOPE)
endfunction()
