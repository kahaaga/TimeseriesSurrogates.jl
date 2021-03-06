using DSP, Random
export AutoRegressive

"""
    AutoRegressive(n, method = LPCLevinson())

Autoregressive surrogates of order-`n`. The autoregressive coefficients `φ` are estimated
using `DSP.lpc(x, n, method)`, and thus see the documentation of DSP.jl for possible
`method`s.

While these surrogates are obviously suited to test the null hypothesis whether the data
are coming from a autoregressive process, the Fourier Transform-based surrogates are
probably a better option. The current method is more like an explicit way to
produce surrogates for the same hypothesis by fitting a model.
It can be used as convient way to estimate
autoregressive coefficients and automatically generate surrogates based on them.

The coefficients φ of the autoregressive fit can be found by doing
```julia
sg = surrogenerator(x, AutoRegressive(n))
φ = sg.init.φ
```
"""
struct AutoRegressive{M} <: Surrogate
    n::Int
    m::M
end
AutoRegressive(n::Int) = AutoRegressive(n, LPCLevinson())

function surrogenerator(x, method::AutoRegressive)
    φ, e = lpc(x, method.n, method.m)
    init = (d = Normal(0, std(x)), φ = φ)
    return SurrogateGenerator(method, x, init)
end

function (sg::SurrogateGenerator{<:AutoRegressive})()
    N, φ, d = length(sg.x), sg.init.φ, sg.init.d
    return autoregressive(d, N, φ)
end

function autoregressive(d::Normal{T}, N, φ) where {T}
    f = length(φ)
    z = zeros(T, N+f)
    @inbounds for i in 1:f; z[i] = rand(d); end
    @inbounds for i in f+1:length(z)
        s = zero(T)
        for j in 1:f
            s += φ[j]*z[i-j]
        end
        s += rand(d)
        z[i] = s
    end
    return view(z, f+1:N+f)
end
