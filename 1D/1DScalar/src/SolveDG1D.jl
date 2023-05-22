# coding = "utf-8"
# author: callm1101 | bcynuaa
# date: 2020-05-14

###################################################################################################
# 1D DG method
# solve a equation of the form: ∂tu + ∂x f(u) = 0

module SolveDG1D # module SolveDG1D begin

import LegendrePolynomials as legp;
include("CaseDG1D.jl");
using .CaseDG1D;

function getFluxAtNode(
    case::Case,
    coeff_current::Vector{Float64},
    t::Float64
)::Vector{Float64}
    flux::Vector{Float64} = zeros(Float64, case.n_node);
    flux[1] = case.fuFunction(case.lhsBcFunction(t));
    flux[end] = case.fuFunction(case.rhsBcFunction(t));
    for i_node = 2: case.n_node-1
        # ? todo: limiter should be added here
        index::Vector{Int64} = Vector((i_node-1)*case.n_gauss+1: i_node*case.n_gauss);
        u_lhs::Float64 = case.phi_lrhs[2, :]' * coeff_current[index.-case.n_gauss];
        u_rhs::Float64 = case.phi_lrhs[1, :]' * coeff_current[index];
        # flux[i_node] = case.fuFunction( (u_lhs+u_rhs)/2 );
        flux[i_node] = case.fuFunction( u_lhs );
    end
    return flux;
end

function partFlux(
    case::Case,
    coeff_current::Vector{Float64},
    t::Float64
)::Matrix{Float64}
    flux::Vector{Float64} = getFluxAtNode(case, coeff_current, t);
    flux_lhs::Matrix{Float64} = case.phi_lrhs[1, :] * flux';
    flux_rhs::Matrix{Float64} = case.phi_lrhs[2, :] * flux';
    return flux_rhs[:, 2: end] .- flux_lhs[:, 1: end-1];
end

function getVolumeIntegral(
    case::Case,
    coeff_current::Vector{Float64}
)::Matrix{Float64}
    vol_int::Matrix{Float64} = zeros(Float64, case.n_gauss, case.n_elem);
    for i_elem = 1: case.n_elem
        index::Vector{Int64} = Vector((i_elem-1)*case.n_gauss+1: i_elem*case.n_gauss);
        u_gauss::Vector{Float64} = case.theta * coeff_current[index];
        fu_gauss::Vector{Float64} = case.fuFunction.(u_gauss);
        # ! code below may be a little confusing
        vol_int[:, i_elem] .= (case.gauss_weight' * (fu_gauss .* case.theta_1D))';
    end
    return vol_int;
end

function iterEulerForward(
    case::Case,
    coeff_current::Vector{Float64},
    t::Float64
)::Vector{Float64}
    coeff_next::Vector{Float64} = deepcopy(coeff_current);
    flux_part::Matrix{Float64} = partFlux(case, coeff_current, t);
    vol_int::Matrix{Float64} = getVolumeIntegral(case, coeff_current);
    for i_elem = 1: case.n_elem
        index::Vector{Int64} = Vector((i_elem-1)*case.n_gauss+1: i_elem*case.n_gauss);
        h_k::Float64 = (case.mesh1D[i_elem+1] - case.mesh1D[i_elem])/2;
        coeff_next[index] .+= case.dt/h_k * (vol_int[:, i_elem] .- flux_part[:, i_elem]) ./ case.mass_vector;
    end
    return coeff_next;
end

function getInterpolationMesh(case)::Vector{Float64}
    mesh1D_interpolate::Vector{Float64} = zeros(Float64, case.n_elem*case.interpolation_devide+1);
    for i_elem = 1: case.n_elem
        mesh1D_interpolate[(i_elem-1)*case.interpolation_devide+1: i_elem*case.interpolation_devide+1] .=
            LinRange(case.mesh1D[i_elem], case.mesh1D[i_elem+1], case.interpolation_devide+1);
    end
    return mesh1D_interpolate;
end

function interpolationInsideElem(
    case::Case, coeff_current::Vector{Float64}, t::Float64
)::Vector{Float64}
    map_interval::Vector{Float64} = LinRange(-1., 1., case.interpolation_devide+1);
    u_interpolate::Vector{Float64} = zeros(Float64, case.n_elem*case.interpolation_devide+1);
    for i_elem = 1: case.n_elem
        index::Vector{Int64} = Vector((i_elem-1)*case.n_gauss+1: i_elem*case.n_gauss);
        u_interpolate[(i_elem-1)*case.interpolation_devide+1: i_elem*case.interpolation_devide] .=
            legp.Pl.(map_interval[1:end-1], Vector(0: case.n_gauss-1)') * coeff_current[index];
    end
    u_interpolate[end] = case.rhsBcFunction(t);
    return u_interpolate;
end

function solveCase(case)::Tuple{Vector{Float64}, Matrix{Float64}}
    coeff_current::Vector{Float64} = initialCoeff(case);
    mesh1D_solution::Vector{Float64} = getInterpolationMesh(case);
    N_solution::Int64 = length(mesh1D_solution);
    u_solution::Matrix{Float64} = zeros(Float64, case.n_step+1, N_solution);
    u_solution[1, :] .= case.initialFunction.(mesh1D_solution);
    for i_time = 1: case.n_step
        coeff_current = iterEulerForward(case, coeff_current, case.dt*i_time);
        u_solution[i_time+1, :] .= interpolationInsideElem(case, coeff_current, case.dt*i_time);
    end
    return mesh1D_solution, u_solution;
end

export solveCase;

end # module SolveDG1D end