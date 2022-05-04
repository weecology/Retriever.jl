module Retriever

using PyCall

export check_for_updates, commit, commit_log, create_rdataset
export data_retriever_version, dataset_names
export display_all_rdataset_names, download
export get_dataset_names_upstream, get_rdataset_names
export get_script_citation, get_script_upstream
export install_csv, install_json, install_msaccess, install_mysql
export install_postgres, install_sqlite, install_xml
export reload_scripts, reset_retriever
export update_rdataset_catalog, update_rdataset_contents
export update_rdataset_script

# Create retriever as rt while properly handling precompilation
# See: https://github.com/JuliaPy/PyCall.jl#using-pycall-from-julia-modules
const rt = PyNULL()
function __init__()
    copy!(rt, pyimport_conda("retriever", "retriever", "conda-forge"))
end

"""
```julia
    check_for_updates()
```

Check Retriever scripts for updates.
"""
function check_for_updates()
    rt.check_for_updates()
end

"""
```julia
    commit(dataset, commit_message::String="", path::String="", quiet::Bool=false)
```

Commit Retriever dataset.
"""
function commit(
    dataset,
    commit_message::String = "",
    path::String = "",
    quiet::Bool = false,
)
    rt.commit(dataset, commit_message, path, quiet)
    println("Successfully committed.")
end

"""
```julia
    commit_log(dataset)
```

Get the commit log for a dataset.
"""
function commit_log(dataset)
    rt.commit_log(dataset)
end

"""
```julia
create_rdataset(engine, package::String, dataset_name::String, script_path::Union{String, Nothing}=nothing)
```

Download files for RDatasets to the raw data directory
"""
function create_rdataset(
    engine,
    package::String,
    dataset_name::String,
    script_path::Union{String,Nothing} = nothing,
)
    rt.create_rdataset(engine, package, dataset_name, script_path)
end

"""
```julia
    data_retriever_version()
```

Get Data Retriever version.
"""
function data_retriever_version()
    rt.__version__
end

"""
```julia
    dataset_names()
```

Return list of all available dataset names.
"""
function dataset_names()
    rt.dataset_names()
end


"""
```julia
    display_all_rdataset_names(package_name::Array{String,1}=String[])
```

Displays the list of rdataset names present in the package(s) provided
"""
function display_all_rdataset_names(package_name::Array{String,1} = String[])
    rt.display_all_rdataset_names(package_name)
end

"""
```julia
    download(dataset; path::String="./", quiet::Bool=false,
                subdir::String="", debug::Bool=false, use_cache::Bool=false)
```

Download scripts for retriever.
"""
function download(
    dataset;
    path::String = "./",
    quiet::Bool = false,
    subdir::String = "",
    debug::Bool = false,
    use_cache::Bool = false,
)
    rt.download(dataset, path, quiet, subdir, debug, use_cache)
end

"""
```julia
    get_dataset_names_upstream(keywords::Array{String,1}=String[], licenses::Array{String,1}=String[], repo::String="")
```

Get dataset names upstream scripts.
"""
function get_dataset_names_upstream(
    keywords::Array{String,1} = String[],
    licenses::Array{String,1} = String[],
    repo::String = "",
)
    rt.get_dataset_names_upstream(keywords, licenses, repo)
end

"""
```julia
    get_rdataset_names()
```

Returns a list of all the available RDataset names present
"""
function get_rdataset_names()
    rt.get_rdataset_names()
end

"""
```julia
    get_script_citation(repo::String="")
```

Get citation for the data retriever or scripts.
"""
function get_script_citation(dataset::String = "")
    rt.get_script_citation(dataset)
end

"""
```julia
    get_script_upstream(dataset, repo::String="")
```

Get upstream retriever-recipe's scripts.
"""
function get_script_upstream(dataset, repo::String = "")
    rt.get_script_upstream(dataset, repo)
end


"""
```julia

    install_csv(dataset; table_name::String="", compile::Bool=false,
        data_dir=pwd(), debug::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in csv format.
"""
function install_csv(
    dataset;
    table_name::String = "{db}_{table}",
    data_dir = pwd(),
    debug::Bool = false,
    use_cache::Bool = true,
)
    rt.install_csv(dataset, table_name, data_dir, debug, use_cache)
end


"""
```julia
    install_json(dataset; table_name::String="", data_dir=pwd(),
    debug::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in json format.
"""
function install_json(
    dataset;
    table_name::String = "{db}_{table}.json",
    data_dir = pwd(),
    debug::Bool = false,
    use_cache::Bool = true,
)
    rt.install_json(dataset, table_name, data_dir, debug, use_cache)

end


"""
```julia
    install_msaccess(dataset; file::String="", table_name::String="",
                data_dir=pwd(), debug::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in msacces.
"""
function install_msaccess(
    dataset;
    file::String = "",
    table_name::String = "",
    data_dir = pwd(),
    debug::Bool = false,
    use_cache::Bool = true,
)
    rt.install_msaccess(dataset, file, table_name, data_dir, debug, quiet, use_cache)
end


"""
```julia
    install_mysql(dataset; user::String="root",
                password::String="", host::String="localhost",
                port::Int=3306, database_name::String="", table_name::String="",
                compile::Bool=false, debug::Bool=false, quiet::Bool=false,
                use_cache::Bool=true)
```

Install Retriever scripts in mysql database.
"""
function install_mysql(
    dataset;
    user::String = "root",
    password::String = "",
    host::String = "localhost",
    port::Int = 3306,
    database_name::String = "{db}",
    table_name::String = "{db}.{table}",
    debug::Bool = false,
    use_cache::Bool = true,
)
    rt.install_mysql(
        dataset,
        user,
        password,
        host,
        port,
        database_name,
        table_name,
        debug,
        use_cache,
    )
end


"""
```julia
    install_postgres(dataset; user::String="postgres",
                password::String="", host::String="localhost",
                port::Int=5432, database::String="postgres",
                database_name::String="", table_name::String="", bbox::Any=[],
                debug::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in database.
"""
function install_postgres(
    dataset;
    user::String = "postgres",
    password::String = "",
    host::String = "localhost",
    port::Int = 5432,
    database::String = "postgres",
    database_name::String = "{db}",
    table_name::String = "{db}.{table}",
    bbox::Any = [],
    debug::Bool = false,
    use_cache::Bool = true,
)

    rt.install_postgres(
        dataset,
        user,
        password,
        host,
        port,
        database,
        database_name,
        table_name,
        bbox,
        debug,
        use_cache,
    )
end


"""
```julia
    install_sqlite(dataset; file::String="", table_name::String="",
                data_dir=pwd(), debug::Bool=false,
                use_cache::Bool=true)
```

Install Retriever scripts in database.
"""
function install_sqlite(
    dataset;
    file::String = "",
    table_name::String = "{db}.{table}",
    data_dir = pwd(),
    debug::Bool = false,
    use_cache::Bool = true,
)
    return rt.install_sqlite(dataset, file, table_name, data_dir, debug, use_cache)
end


"""
```julia
    install_xml(dataset; table_name::String="", compile::Bool=false, data_dir=pwd(), 
            debug::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in xml format.
"""
function install_xml(
    dataset;
    table_name::String = "{db}_{table}.xml",
    data_dir = pwd(),
    debug::Bool = false,
    use_cache::Bool = true,
)
    rt.install_xml(dataset, table_name, data_dir, debug, use_cache)

end


"""
```julia
    reload_scripts()
```

Retriever reload scripts.
"""
function reload_scripts()
    rt.reload_scripts()
end


"""
```julia
    reset_retriever(scope::String="all", ask_permission::Bool=true)
```

Retriever reset scripts or data or all.
"""
function reset_retriever(scope::String = "all", ask_permission::Bool = true)
    rt.reset_retriever(scope, ask_permission)
end


"""
```julia
    update_rdataset_catalog(test::Bool=false)
```

Updates the datasets_url.json from the github repo
"""
function update_rdataset_catalog(test::Bool = false)
    rt.update_rdataset_catalog(test)
end


"""
```julia
    update_rdataset_contents(data_obj::Dict{String, String}, package::String, dataset_name::String, json_file::Dict{String, String})
```

Update the contents of json script
"""
function update_rdataset_contents(
    data_obj::Dict{String,String},
    package::String,
    dataset_name::String,
    json_file::Dict{String,String},
)
    rt.update_rdataset_contents(data_obj, package, dataset_name, json_file)
end


"""
```julia
    update_rdataset_script(data_obj, dataset_name, package, script_path)
```

Renames and updates the RDataset script
"""
function update_rdataset_script(
    data_obj::Dict{String,String},
    dataset_name::String,
    package::String,
    script_path::String,
)
    rt.update_rdataset_script(data_obj, dataset_name, package, script_path)
end


end # module
