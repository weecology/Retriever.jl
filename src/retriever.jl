module Retriever


"""
    datasets()

Return a list of all available datasets.

# Examples
```julia
julia> Retriever.datasets()
SubString{String}["abalone-age","amniote-life-hist","antarctic-breed-bird"....]
""
```
"""
function datasets()
    command = `retriever ls`
    dataset = split(strip(readstring(command)), "\n")
    dataset_list = dataset[3:length(dataset)]
    return dataset_list
end

"""
    update()

Update all available datasets. Return `true` on successful update,
`false` otherwise.

# Examples
```julia
julia> Retriever.update()
Please wait while retriever updates the scripts...
```
"""
function update()
    println("Please wait while retriever updates the scripts...")
    command = `retriever update`
    try
        oldout = STDOUT # redirecting STDOUT so that console output is not displayed
        (rd,wr) = redirect_stdout()
        run(command)
        redirect_stdout(oldout)
        return true
    catch
        return false
    end
end

end
