"""
    RandomShuffle() <: Surrogate

Generate a random constrained surrogate by shifting values around.

This method destroys any linear
correlation in the signal, but preserves its amplitude distribution.
"""
struct RandomShuffle <: Surrogate end
surrogate(x, ::RandomShuffle) = randomshuffle(x)

function randomshuffle(ts::AbstractArray{T, 1} where T)
    n = length(ts)
    ts[sample(1:n, n, replace = false)]
end
