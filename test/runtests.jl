# !/usr/bin/env julia

using MySQL
using Pkg
using PyCall
using Retriever
using SQLite
using Test

# Run tests

@time include("test_retriever.jl")
