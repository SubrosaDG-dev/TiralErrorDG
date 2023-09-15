"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-09-08 23:52:57
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * 
 """

import Gmsh: gmsh

function readMsh(msh_filename::AbstractString)::Tuple
    gmsh.initialize();
    gmsh.open(msh_filename);
    node_tags, node_coords, _ = gmsh.model.mesh.getNodes();
    node_tags_::Vector{Int64} = Int64.(node_tags);
    node_coords_::Matrix{Float64} = Float64.(node_coords);
    node_coords_ = Matrix(reshape(node_coords_, (3, Int64(length(node_coords) / 3)))');
    gmsh.finalize();
    return node_tags_, node_coords_;
end