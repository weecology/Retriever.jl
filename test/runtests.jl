#!/usr/bin/env julia
push!(LOAD_PATH,"../src/Retriever.jl")
include("../src/Retriever.jl")

Pkg.add("SQLite")
Pkg.add("MySQL")

using Base.Test

# Run tests

tic()
@time include("test_retriever.jl")
toc()
