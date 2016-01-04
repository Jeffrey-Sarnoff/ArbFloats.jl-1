module ArbFloats

import Base: convert, promote_rule, promote_type,
    hash, string, show, showcompact,
    (<),(<=),(==),(!=),(>=),(>),isless,isequal,
    zero,one,ldexp,floor,ceil,
    (+),(-),(*),(/),(%),(^),sqrt,hypot,
    exp,expm1,log,log1p,log2,log10,
    sin,cos,tan,cot,
    asin,acos,atan,acot,atan2,
    sinh,cosh,tanh,coth,
    asinh,acosh,atanh,acoth

import Nemo: ArbField, arb, 
    ball, midpoint, radius, trim,
    iszero, isnonzero, isone, isfinite, isexact, 
    isint, ispositive, isnonnegative, isnegative, isnonpositive,
    const_pi, const_e, const_log2, const_log10, const_euler, const_catalan,
    sincos, sinhcosh
    # floor, ceil, sqrt, hypot, atan2, sincos, sinhcosh

typealias Ball arb # types are capitalized in Julia
typealias SystemNum Union{Float64,Float32,Float16,Int128,Int64,Int32,Int16}

export showball, radius, midpoint

if isdefined(Main,:UseArbFloat30) || (!isdefined(Main,:UseArbFloat70) & !isdefined(Main,:UseArbFloat140) & !isdefined(Main,:UseArbFloat300))
export ArbFloat30

immutable (ArbFloat30) <: Real
   re::Ball
end
Real30 = ArbField(127)
convert{T<:SystemNum}(::Type{ArbFloat30}, x::T) = (ArbFloat30)(Real30(x))

TypeSym = :ArbFloat30; RoundDigs=30; FmtStr="%0.30g"
include("type.jl")
end

if isdefined(Main,:UseArbFloat70) && Main.UseArbFloat70==true
export ArbFloat70

immutable (ArbFloat70) <: Real
   re::Ball
end
Real70 = ArbField(255)
convert{T<:SystemNum}(::Type{ArbFloat70}, x::T) = (ArbFloat70)(Real70(x))

TypeSym = :ArbFloat70; RoundDigs=70; FmtStr="%0.70g"
include("type.jl")
end

if isdefined(Main,:UseArbFloat140) && Main.UseArbFloat140==true
export ArbFloat140

immutable (ArbFloat140) <: Real
   re::Ball
end
Real140 = ArbField(511)
convert{T<:SystemNum}(::Type{ArbFloat140}, x::T) = (ArbFloat140)(Real140(x))

TypeSym = :ArbFloat140; RoundDigs=140; FmtStr="%0.140g"
include("type.jl")
end

if isdefined(Main,:UseArbFloat300) && Main.UseArbFloat300==true
export ArbFloat300

immutable (ArbFloat300) <: Real
   re::Ball
end
Real300 = ArbField(1023)
convert{T<:SystemNum}(::Type{ArbFloat300}, x::T) = (ArbFloat300)(Real300(x))

TypeSym = :ArbFloat300; RoundDigs=300; FmtStr="%0.300g"
include("type.jl")
end

# intertype promotion

if isdefined(:ArbFloat30)

if isdefined(:ArbFloat70)
  promote_rule(::Type{ArbFloat30}, ::Type{ArbFloat70}) = ArbFloat30
  convert(::Type{ArbFloat30}, x::ArbFloat70) = ArbFloat30(x.re)
elseif isdefined(:ArbFloat140)
  promote_rule(::Type{ArbFloat30}, ::Type{ArbFloat140}) = ArbFloat30
  convert(::Type{ArbFloat30}, x::ArbFloat140) = ArbFloat30(x.re)
elseif isdefined(:ArbFloat300)
  promote_rule(::Type{ArbFloat30}, ::Type{ArbFloat300}) = ArbFloat30
  convert(::Type{ArbFloat30}, x::ArbFloat300) = ArbFloat30(x.re)
end

elseif isdefined(:ArbFloat70)

if isdefined(:ArbFloat140)
  promote_rule(::Type{ArbFloat70}, ::Type{ArbFloat140}) = ArbFloat70
  convert(::Type{ArbFloat70}, x::ArbFloat140) = ArbFloat70(x.re)
elseif isdefined(:ArbFloat300)
  promote_rule(::Type{ArbFloat70}, ::Type{ArbFloat300}) = ArbFloat70
  convert(::Type{ArbFloat70}, x::ArbFloat300) = ArbFloat70(x.re)
end

elseif isdefined(:ArbFloat140)

if isdefined(:ArbFloat300)
  promote_rule(::Type{ArbFloat140}, ::Type{ArbFloat300}) = ArbFloat140
  convert(::Type{ArbFloat140}, x::ArbFloat300) = ArbFloat140(x.re)
end

end # promotions

end # ArbFloats
