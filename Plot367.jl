using Plots

function levelset(x, y, f, grad_fn, point, dz=5)
    pyplot();

    z = f(point...);
    grad = grad_fn(point...);
    
    tangent = -grad[1]/grad[2] .* (x .- 1);
    plt = contour(x, y, f, levels=[z - dz, z, z + dz]);
    quiver!([point[1]], [point[2]], gradient=([grad[1]], [grad[2]]));
    plot!(x, tangent, style=:dash, width=2, label="tangent")
    ylims!(-2, 3.5)
    return plt
end

function linearapprox(x, y, f, grad_fn, xbar)
    f_x = f(xbar...);
    ∇f_x = grad_fn(xbar...);

    surface(x, y, f, camera=(-30, 30), c=:BuGn_3, legend=false)
    contour!(x, y, f)
    scatter!([xbar[1]], [xbar[2]], [f_x], markersize=10, c=:Black)
    surface!(x, y, (x, y) -> f_x + ∇f_x' * ([x; y] - [xbar[1]; xbar[2]]), c=:Blues_3)
end

