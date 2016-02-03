#use JuMP to solve minimum set cover for a binary inout matrix
using JuMP

function setcover()
    A = readdlm("binary_array.csv", ',');

    # specify model
    m = Model()
    nSets, nNodes = size(A)

    @defVar(m,x[1:nSets],Bin);
    @setObjective(m,Min,sum(x));
    @addConstraint(m,A' * x .>= 1);

    @time solve(m)

    x_result = getValue(x)

    println(sum(x_result)," set collections provide cover")
    writedlm("set_cover_result.csv",x_result, ',')
end

setcover()
