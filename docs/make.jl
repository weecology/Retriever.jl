push!(LOAD_PATH,"../src/Retriever.jl")
include("../src/Retriever.jl")
using Retriever
using Documenter

makedocs(
    modules = [Retriever],
    clean = false,
    format = :html,
    sitename = "Retriever",
    authors = "Ethan White",
    pages = [
        "Home" => "intro.md",
        "Installation Guide" => "tutorial.md",
        "Source" => "index.md",
        "Command Documentation" => "lib/public.md"
    ]
)

# deploydocs(
#     repo   = "github.com/henrykironde/Retriever.jl",
#     target = "build",
#     osname = "linux",
#     #osname = "osx",
#     julia  = "0.6",
#     deps   = nothing,
#     deps = Deps.pip("Retriever"),
#     make   = nothing
# )
