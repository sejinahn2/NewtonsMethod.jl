module NewtonsMethod

using ForwardDiff, LinearAlgebra


D(g) = x -> ForwardDiff.derivative(g, x)



function newtonroot(f,fprime, x_0=0.8, tolerance=1.0E-7, maxiter=1000)
    # setup the algorithm
    x_old = x_0
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = x_old-f(x_old)/fprime(x_old) # use the passed in map
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (x_old, normdiff, iter)
end

newtonroot(f,x_0=0.8, tolerance=1.0E-7, maxiter=1000)=newtonroot(f,D(f), x_0, tolerance, maxiter)

export newtonroot


end # module
