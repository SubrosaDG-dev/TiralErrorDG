"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-06-01 16:01:51
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * elem_type.jl
 * This file is used to define the element type.
 """

"""
# Reference
 
- [Gmsh manual](https://gmsh.info/doc/texinfo/gmsh.html#MSH-ASCII-file-format)

# Gmsh Reference Manual 4.11.0.pdf Page 357

# elem_types: 1: 2-node line
#             2: 3-node triangle
#             3: 4-node quadrangle
"""
const kElemInfo = Dict(
    1 => Dict(
        :kName => "2-node line",
        :kDim => 1,
        :kTag => 1,
        :kNodeNum => 2,
        :kAdjacencyNum => 2
    ),
    2 => Dict(
        :kName => "3-node triangle",
        :kDim => 2,
        :kTag => 2,
        :kNodeNum => 3,
        :kAdjacencyNum => 3
    ),
    3 => Dict(
        :kName => "4-node quadrangle",
        :kDim => 2,
        :kTag => 3,
        :kNodeNum => 4,
        :kAdjacencyNum => 4
    )
);