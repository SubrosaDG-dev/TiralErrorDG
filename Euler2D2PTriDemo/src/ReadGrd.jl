
  # Author: Yufei Liu | Chenyu Bao
  # Create Time: 2023-09-15 18:47:25
  # Description: a trial fof 2D DG method with order 2
 

include("Base.jl");
include("Meshes.jl");

# using Parsers;

function readGrdMeshBasicInfo(grd_filename::String)::Tuple{Isize, Isize, Isize}
    grd_file::IOStream = open(grd_filename, "r");
    n_nodes::Isize, n_lines::Isize, n_tris::Isize = parse.(Isize, split(readline(grd_file)));
    close(grd_file);
    return (n_nodes, n_lines, n_tris);
end

function readGrdMesh(grd_filename::String)::GrdMesh
    n_nodes::Isize, n_lines::Isize, n_tris::Isize, = readGrdMeshBasicInfo(grd_filename);
    file_lines::Array{String, 1} = readlines(grd_filename)[2: end];
    nodes::Matrix{Rfloat} = zeros(Rfloat, n_nodes, 2);
    lines::Matrix{Isize} = zeros(Isize, n_lines, 4);
    tris::Matrix{Isize} = zeros(Isize, n_tris, 3);
    for i_node::Isize = 1: n_nodes
        nodes[i_node, :] = parse.(Rfloat, split(file_lines[i_node]));
    end
    for i_line::Isize = 1: n_lines
        lines[i_line, :] = parse.(Isize, split(file_lines[n_nodes + i_line]));
    end
    for i_tri::Isize = 1: n_tris
        tris[i_tri, :] = parse.(Isize, split(file_lines[n_nodes + n_lines + i_tri]));
    end
    return GrdMesh(n_nodes, n_lines, n_tris, nodes, lines, tris);
end