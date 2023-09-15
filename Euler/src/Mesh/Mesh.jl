"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-09-08 23:49:02
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * 
 """

struct Mesh
    dim_::Int64
    node_num_::Int64
    node_tags_::Vector{Int64}
    node_::Matrix{Float64}
end