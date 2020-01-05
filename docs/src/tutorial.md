# Data Retriever using Julia

The wrapper module for [Data Retriever](https://www.data-retriever.org) has been implemented as [Retriever](https://github.com/weecology/Retriever.jl.git).
All the functions work and feel the same as the python Retriever module.
The module has been created using ``PyCall`` hence all the functions are analogous to the functions of Retriever python module.


## Installation

To use Retriever, you first need to
[install the core Python retriever package](https://www.data-retriever.org).
The simplest way to do this is to let Julia install it into an isolated Python
environment by setting an environmental variable prior to installation:

```julia
julia> ENV["PYTHON"]=""
julia> Pkg.add("Retriever")
```

Alternatively you can install it yourself using either `conda` or `pip`
(Python's package managers) which will also provide access to the package in
Python and the command line interface.

```bash
conda install -c conda-forge retriever
```

```bash
pip install retriever
```

Then install the Julia package *without* setting the environmental variable:

```julia

    julia> Pkg.add("Retriever")

```

To install from Source, download or checkout the source from the [github page](https://github.com/weecology/Retriever.jl).

Go to `Retriever.jl/src`. Run Julia.

```julia

    julia> include("Retriever.jl")

```

(Note: If you want help in installing Julia you can follow this [tutorial](https://medium.com/@shivamnegi2019/julia-beginners-guide-part-1-a9c369128c78)

## Tutorial

The Retriever has both built-in and recipe scripts.
The Retriever's built-in scripts as part of the installation.
Each recipe provides the information to retriever on how to install a dataset. 
Recipes are contributed by a variety of users including data owners, data users, and the Retriever maintainers.

Get list of all the available datasets in Retriever.

```julia

    """ Function Definition """
    function dataset_names()

```

```julia

    julia> Retriever.dataset_names()

```

Updating scripts to the latest version.

```julia

    """ Function Definition """
    function check_for_updates()

```

```julia

    julia> Retriever.check_for_updates()

```

Get list of datasets based on searching by keywords and licenses..

```julia

    """ Function Definition """
    function get_dataset_names_upstream(keywords::String="", licenses::String="", repo::String="")

```

```julia

    julia> Retriever.get_dataset_names_upstream("birds data")

```

Get the recipe for a specific dataset.

```julia

    """ Function Definition """
    function get_script_upstream(dataset, repo::String="")

```

```julia

    julia> Retriever.get_script_upstream("fia-florida")

```

Reload scripts.

```julia

    """ Function Definition """
    function reload_scripts()

```

```julia

    julia> Retriever.reload_scripts()

```

Delete information stored by Retriever which could be scripts, connections or data.

```julia

    """ Function Definition """
    function reset_retriever(; scope::AbstractString="all")

```

```julia

    """ Using default variable all"""
    julia> Retriever.reset_retriever()
    """ Set scope as scripts """
    julia> Retriever.reset_retriever(scope="scripts")

```

To download datasets the ``download`` function can be used.

```julia

    """ Function Definition """
    function download(dataset; path::AbstractString="./", quite::Bool=false,
                subdir::Bool=false, use_cache::Bool=false, debug::Bool=false)

```

```julia

    julia> Retriever.download("iris")

```

Installing scripts into engines.


```julia

    """ Function Definition """
    function install_csv(dataset; table_name=nothing, compile::Bool=false,
                debug::Bool=false, quite::Bool=false, use_cache::Bool=true)

    function install_mysql(dataset; user::AbstractString="root",
                password::AbstractString="", host::AbstractString="localhost",
                port::Int=3306, database_name=nothing, table_name=nothing,
                compile::Bool=false, debug::Bool=false, quite::Bool=false,
                use_cache::Bool=true)

    function install_postgres(dataset; user::AbstractString="postgres",
                password::AbstractString="", host::AbstractString="localhost",
                port::Int=5432, database::AbstractString="postgres",
                database_name=nothing, table_name=nothing, compile::Bool=false,
                debug::Bool=false, quite::Bool=false, use_cache::Bool=true)

    function install_sqlite(dataset; file=nothing, table_name=nothing,
                compile::Bool=false, debug::Bool=false, quite::Bool=false,
                use_cache::Bool=true)

    function install_msaccess(dataset; file=nothing, table_name=nothing,
                compile::Bool=false, debug::Bool=false, quite::Bool=false,
                use_cache::Bool=true)

    function install_json(dataset; table_name=nothing, compile::Bool=false,
                debug::Bool=false, quite::Bool=false, use_cache::Bool=true)

    function install_xml(dataset; table_name=nothing, compile::Bool=false,
                debug::Bool=false, quite::Bool=false, use_cache::Bool=true)

```

```julia

    julia> Retriever.install_csv("iris")
    julia> Retriever.install_mysql("iris")
    julia> Retriever.install_postgres("iris")
    julia> Retriever.install_sqlite("iris")
    julia> Retriever.install_msaccess("iris")
    julia> Retriever.install_json("iris")
    julia> Retriever.install_xml("iris")

```

## Retriever Provenance


Retriever allows committing of datasets and installation of the committed dataset into the database of your choice at a
later date.
This ensures that the previous outputs/results can be produced easily.

 
Retriever supports committing of a dataset into a compressed archive.

```julia

    julia> Retriever.commit("portal")
    julia> Retriever.commit('abalone-age', 'First chapter data version 1')
    julia> Retriever.commit_log("portal")

```

You can install committed datasets by using the hash-value or by providing the path of the compressed archive.
Installation using hash-value is supported only for datasets stored in the provenance directory.

```julia

    julia> Retriever.install_sqlite('abalone-age-02ee77.zip')
    julia> Retriever.install_sqlite('abalone-age', '02ee77')

```