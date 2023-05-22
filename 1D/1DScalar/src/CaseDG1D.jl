# coding = "utf-8"
# author: callm1101 | bcynua
# date: 2020-05-12

###################################################################################################
# 1D DG method
# solve a equation of the form: ∂tu + ∂x f(u) = 0

module CaseDG1D # module CaseDG1D begin

# ref: 
# https://juliapackages.com/p/legendrepolynomials
# https://juliapackages.com/p/gaussquadrature

import LegendrePolynomials as legp;
import GaussQuadrature as gq;

struct Case
    mesh1D::Vector{Float64};
    n_node::Int64;
    n_elem::Int64;
    n_gauss::Int64;
    gauss_weight::Vector{Float64};
    gauss_points::Vector{Float64};
    mesh1D_gauss::Vector{Float64};
    n_step::Int64;
    dt::Float64;
    fuFunction::Function;
    initialFunction::Function;
    lhsBcFunction::Function;
    rhsBcFunction::Function;
    theta::Matrix{Float64};
    theta_1D::Matrix{Float64};
    phi_lrhs::Matrix{Float64};
    mass_vector::Vector{Float64};
    interpolation_devide::Int64;
end

function generateMesh(
    x_begin::Float64,
    x_end::Float64,
    n_node::Int64
)::Vector{Float64}
    mesh1D::Vector{Float64} = LinRange(x_begin, x_end, n_node);
    return mesh1D;
end

function generateCase(
    mesh1D::Vector{Float64},
    n_gauss::Int64,
    n_step::Int64,
    dt::Float64,
    fuFunction::Function,
    initialFunction::Function,
    lhsBcFunction::Function,
    rhsBcFunction::Function,
    interpolation_devide::Int64
)::Case
    n_node::Int64 = length(mesh1D);
    n_elem::Int64 = n_node - 1;
    gauss_points::Vector{Float64}, gauss_weight::Vector{Float64} = gq.legendre(n_gauss);
    mesh1D_gauss::Vector{Float64} = zeros(Float64, n_elem*n_gauss);
    for i_elem = 1: n_elem
        x_mid::Float64 = (mesh1D[i_elem+1]+mesh1D[i_elem])/2;
        interval_length::Float64 = (mesh1D[i_elem+1]-mesh1D[i_elem])/2;
        mesh1D_gauss[(i_elem-1)*n_gauss+1: i_elem*n_gauss] = interval_length * gauss_points .+ x_mid;
    end
    case::Case = Case(
        mesh1D, n_node, n_elem,
        n_gauss, gauss_weight, gauss_points, mesh1D_gauss,
        n_step, dt,
        fuFunction,
        initialFunction,
        lhsBcFunction, rhsBcFunction,
        legp.Pl.(gauss_points, Vector(0: n_gauss-1)'),
        legp.dnPl.(gauss_points, Vector(0: n_gauss-1)', 1),
        legp.Pl.([-1., 1.], Vector(0: n_gauss-1)'),
        (2/(2*Vector(0: n_gauss-1) .+ 1))',
        interpolation_devide
    );
    return case;
end

function initialCoeff(
    case::Case
)::Vector{Float64}
    u_0::Vector{Float64} = case.initialFunction.(case.mesh1D_gauss);
    coeff::Vector{Float64} = zeros(Float64, case.n_elem*case.n_gauss);
    for i_elem = 1: case.n_elem
        index::Vector{Int64} = (i_elem-1)*case.n_gauss+1: i_elem*case.n_gauss;
        u_0_elem::Vector{Float64} = u_0[index];
        coeff[index] .= case.theta \ u_0_elem;
    end
    return coeff;
end

export Case;
export generateMesh;
export generateCase;
export initialCoeff;

end # module CaseStruct end

###################################################################################################