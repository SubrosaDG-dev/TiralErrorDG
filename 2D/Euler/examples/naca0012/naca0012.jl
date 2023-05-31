# coding: utf-8
# author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
# date: 2023.05.31

###################################################################################################
# This file is used to generate mesh for naca0012.

import DelimitedFiles;
import Gmsh: gmsh;

function generateMesh()
    # Generate the mesh
    # below is prepared for generating mesh
    naca0012_points::Matrix{Float64} = DelimitedFiles.readdlm("naca0012.dat"; skipstart=1);
    outer_square_side_length::Float64 = 10.;
    farfield_points::Matrix{Float64} = [
        -outer_square_side_length     -outer_square_side_length      0.;
        outer_square_side_length      -outer_square_side_length      0.;
        outer_square_side_length      outer_square_side_length       0.;
        -outer_square_side_length     outer_square_side_length       0.
    ];
    kLc1::Float64 = 1.0;
    kLc2::Float64 = 1e-2;
    farfield_points_index::Vector{Int64} = Int64[];
    naca0012_points_index::Vector{Int64} = Int64[];
    farfield_lines_index::Vector{Int64} = Int64[];
    # below is initialize gmsh
    gmsh.initialize();
    gmsh.option.setNumber("General.Terminal", 1);
    gmsh.model.add("naca0012");
    # below is add points and lines
    for i = 1: size(farfield_points)[1]
        push!(farfield_points_index, gmsh.model.geo.addPoint( farfield_points[i, 1], farfield_points[i, 2], farfield_points[i, 3], kLc1) );
    end
    for i = 1: size(naca0012_points)[1]
        push!(naca0012_points_index, gmsh.model.geo.addPoint( naca0012_points[i, 1], naca0012_points[i, 2], naca0012_points[i, 3], kLc2) );
    end
    for i = 1: size(farfield_points_index)[1]
        push!(
            farfield_lines_index,
            gmsh.model.geo.addLine(
                farfield_points_index[i],
                farfield_points_index[mod(i, size(farfield_points_index)[1]) + 1]
            )
        );
    end
    push!(naca0012_points_index, naca0012_points_index[1]);
    # below is add line loops and surface
    naca0012_line::Int64 = gmsh.model.geo.addSpline(naca0012_points_index);
    farfield_line_loop::Int64 = gmsh.model.geo.addCurveLoop(farfield_lines_index);
    naca0012_line_loop::Int64 = gmsh.model.geo.addCurveLoop([-naca0012_line]);
    naca0012_plane_surface::Int64 = gmsh.model.geo.addPlaneSurface([farfield_line_loop, naca0012_line_loop]);

    gmsh.model.geo.synchronize();
    gmsh.model.addPhysicalGroup(1, farfield_lines_index, -1, "bc-1");
    gmsh.model.addPhysicalGroup(1, [naca0012_line], -1, "bc-2");
    gmsh.model.addPhysicalGroup(2, [naca0012_plane_surface], -1, "vc-1");
    gmsh.model.mesh.generate(2);
    gmsh.model.mesh.optimize("Netgen");
    gmsh.write("naca0012.msh");
    gmsh.clear();
    gmsh.finalize();
end

function main()
    @time generateMesh();
end

main()

###################################################################################################