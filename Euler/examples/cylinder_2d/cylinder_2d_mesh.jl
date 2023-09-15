"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-09-08 21:11:00
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * 
 """

import Gmsh: gmsh;

function generateMesh(mesh_file::AbstractString)
    farfield_point = [-5 -5 0; 5 -5 0; 5 5 0; -5 5 0]
    cylinder_point = [0 0 0; -1 0 0; 0 -1 0; 1 0 0; 0 1 0]
    farfield_point_tag = Int[]
    cylinder_point_tag = Int[]
    farfield_line_tag = Int[]
    cylinder_line_tag = Int[]
    gmsh.initialize()
    gmsh.option.setNumber("Mesh.SecondOrderLinear", 1)
    gmsh.model.add("cylinder_2d")
    for row in eachrow(farfield_point)
        push!(farfield_point_tag, gmsh.model.occ.addPoint(row[1], row[2], row[3], 0.5))
    end
    for row in eachrow(cylinder_point)
        push!(cylinder_point_tag, gmsh.model.occ.addPoint(row[1], row[2], row[3], 0.05))
    end
    for i in 1: size(farfield_point_tag)[1]
        push!(farfield_line_tag, gmsh.model.occ.addLine(farfield_point_tag[i], farfield_point_tag[mod1(i+1, length(farfield_point_tag))]))
    end
    for i in 2: size(cylinder_point_tag)[1]
        push!(cylinder_line_tag, gmsh.model.occ.addCircleArc(cylinder_point_tag[i], cylinder_point_tag[1], cylinder_point_tag[mod1(i, length(cylinder_point_tag)-1)+1]))
    end
    farfield_line_loop = gmsh.model.occ.addCurveLoop(farfield_line_tag)
    cylinder_line_loop = gmsh.model.occ.addCurveLoop(cylinder_line_tag)
    cylinder_plane_surface = gmsh.model.occ.addPlaneSurface([farfield_line_loop, cylinder_line_loop])
    gmsh.model.occ.synchronize()
    cylinder_line_tag_double_cast = convert(Vector{Float64}, cylinder_line_tag)
    cylinder_boundary_layer = gmsh.model.mesh.field.add("BoundaryLayer")
    gmsh.model.mesh.field.setNumbers(cylinder_boundary_layer, "CurvesList", cylinder_line_tag_double_cast)
    gmsh.model.mesh.field.setNumber(cylinder_boundary_layer, "Size", 0.05)
    gmsh.model.mesh.field.setNumber(cylinder_boundary_layer, "Ratio", 1.1)
    gmsh.model.mesh.field.setNumber(cylinder_boundary_layer, "Quads", 1)
    gmsh.model.mesh.field.setNumber(cylinder_boundary_layer, "Thickness", 0.5)
    gmsh.model.mesh.field.setAsBoundaryLayer(cylinder_boundary_layer)
    gmsh.model.addPhysicalGroup(1, farfield_line_tag, -1, "bc-1")
    gmsh.model.addPhysicalGroup(1, cylinder_line_tag, -1, "bc-2")
    gmsh.model.addPhysicalGroup(2, [cylinder_plane_surface], -1, "vc-1")
    gmsh.model.mesh.generate(2)
    gmsh.model.mesh.setOrder(3)
    gmsh.write(mesh_file)
end

function main()
    generateMesh("examples//cylinder_2d//cylinder_2d.msh")
end

main()