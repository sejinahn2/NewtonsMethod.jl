using ForwardDiff

# operator to get the derivative of this function using AD
D(g) = x -> ForwardDiff.derivative(g, x)

# example usage: create a function and get the derivative
g(x) = (x-1)^3
g_prime = D(g)

using Plots, LinearAlgebra, Statistics
function fixedpointmap(f, x_0, tolerance, maxiter)
    # setup the algorithm
    x_old = x_0
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = f(x_old)  # use the passed in map
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (x_old, normdiff, iter)
end

# define a map and parameters
f(v) = v-g(v)/g_prime(v) # note that p and β are used in the function!

maxiter = 1000
tolerance = 1.0E-7
v_initial = 0.8 # initial condition

v_star, normdiff, iter = fixedpointmap(f, v_initial, tolerance, maxiter)
println("Fixed point = $v_star, and |f(x) - x| = $normdiff in $iter iterations")
