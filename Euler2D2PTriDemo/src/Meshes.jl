
  # Author: Yufei Liu | Chenyu Bao
  # Create Time: 2023-09-15 18:35:18
  # Description: a trial fof 2D DG method with order 2
 

using DelimitedFiles;

include("Base.jl");
include("Type.jl");

struct GrdMesh <: AbstractMesh
    n_nodes_::Isize;
    n_lines_::Isize;
    n_tris_::Isize;
    nodes_::Matrix{Rfloat};
    lines_::Matrix{Isize};
    tris_::Matrix{Isize};
end

struct DGMesh <: AbstractMesh
    order_::Isize;
    n_nodes_::Isize;
    n_lines_::Isize;
    n_tris_::Isize;
    nodes_::Matrix{Rfloat};
    lines_::Matrix{Isize};
    tris_::Matrix{Isize};
end

function applyOrderToGrdMesh(order::Isize, grd_mesh::GrdMesh)::DGMesh

end