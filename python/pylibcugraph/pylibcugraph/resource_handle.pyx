# Copyright (c) 2022, NVIDIA CORPORATION.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Have cython use python 3 syntax
# cython: language_level = 3

from pylibcugraph._cugraph_c.cugraph_api cimport (
    cugraph_create_resource_handle,
    cugraph_free_resource_handle,
)


cdef class EXPERIMENTAL__ResourceHandle:
    """
    RAII-stye resource handle class to manage individual create/free calls and
    the corresponding pointer to a cugraph_resource_handle_t
    """
    def __cinit__(self):
        self.c_resource_handle_ptr = cugraph_create_resource_handle()
        # FIXME: check for error

    def __dealloc__(self):
        # FIXME: free only if handle is a valid pointer
        cugraph_free_resource_handle(self.c_resource_handle_ptr)
