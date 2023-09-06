"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-06-02 20:41:46
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * get_mesh.jl: get mesh from gmsh
 """

import Gmsh: gmsh;

function getNodes()
    nodes = gmsh.model.mesh.getNodes()
    return nodes
end