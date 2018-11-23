using NewtonsMethod
using Test

#Test method 1
f(x)=x^2-4.0
f′(x)=2x
@test newtonroot(f,f′,x₀=0.2)[1]≈2.0 atol=0.000001

f(x)=log(x)-20
f′(x)=1/x
@test newtonroot(f,f′,x₀=0.2)[1]≈4.851651954097909e8 atol=0.000001

f(x)=3x^2-5x+1
f′(x)=6x-5
@test newtonroot(f,f′,x₀=0.2)[1]≈0.23240824122077 atol=0.000001

f(x)=-10x^3-5x^2+20
f′(x)=-20x^2-10x
@test newtonroot(f,f′,x₀=0.2)[1]≈1.11338619006481 atol=0.000001


#Test method 2
f(x)=x^2-4.0
@test newtonroot(f,x₀=0.2)[1]≈2.0 atol=0.000001

f(x)=log(x)-20
@test newtonroot(f,x₀=0.2)[1]≈4.851651954097909e8 atol=0.000001

f(x)=3x^2-5x+1
@test newtonroot(f,x₀=0.2)[1]≈0.23240824122077 atol=0.000001

f(x)=-10x^3-5x^2+20
@test newtonroot(f,x₀=0.2)[1]≈1.11338619006481 atol=0.000001


#Test Big Float (Not really sure what to do here. What I did is compare the root with a BigFloat)
f(x)=3x^2-5x+1
a=BigFloat(0.23240824122077)
@testset "BigFloat" begin
  @test newtonroot(f,x₀=0.2)[1]≈0.23240824122077 atol=0.000001
  @test newtonroot(f,x₀=0.2)[1]≈a atol=0.000001
 end;

#(I also set all parameters to be BigFloat)
f(x)=3x^2-5x+1
@test newtonroot(f,x₀= BigFloat(0.2),tolerance = BigFloat(1E-7), maxiter = BigFloat(1000))[1]≈0.23240824122077 atol=0.000001


#Test non-convergence (return nothing)
f(x)=2+x^2
@test newtonroot(f,x₀=0.2)==nothing


#Test maxiter (first should return the value, second should return nothing)
f(x)=log(x)-20
a=newtonroot(f,x₀=0.2)[1] #Algorithm needs 17 iterations in this case
b=newtonroot(f,x₀=0.2,maxiter=5)
@testset "maxiter" begin
  @test a≈4.851651954097909e8 atol=0.000001 
  @test b==nothing
 end;


#Test tolerance (As tolerance parameter increases, the code is less accurate)
f(x)=3x^2-5x+1
a=newtonroot(f,x₀=1)[1]
b=newtonroot(f,x₀=1, tolerance=0.0005)[1]
c=newtonroot(f,x₀=1, tolerance=0.05)[1]
@test f(a)<f(b)<f(c)
