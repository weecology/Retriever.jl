module Retriever
using PyCall

@pyimport retriever as rt

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
    dataset_names()
```

Return list of all available dataset names.
"""
function dataset_names()
    rt.dataset_names()
end

"""
```julia
    download(dataset; path::String="./", quite::Bool=false,
            subdir::Bool=false, use_cache::Bool=false)
```

Download scripts for retriever.
"""
function download(dataset; path::String="./", quite::Bool=false,
                subdir::Bool=false, use_cache::Bool=false)
    rt.download(dataset, path, quite, subdir, use_cache)
end

"""
```julia

    install_csv(dataset; table_name::String="", compile::Bool=false,

            debug::Bool=false, quite::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in csv format.
"""

function install_csv(dataset; table_name::String="",
                debug::Bool=false, use_cache::Bool=true)
    rt.install_csv(dataset, table_name, debug, use_cache)

end

"""
```julia
    install_mysql(dataset; user::String="root",
                password::String="", host::String="localhost",

                port::Int=3306, database_name::String="", table_name::String="",

                compile::Bool=false, debug::Bool=false, quite::Bool=false,
                use_cache::Bool=true)
```

Install Retriever scripts in mysql database.
"""
function install_mysql(dataset; user::String="root",
                password::String="", host::String="localhost",

                port::Int=3306, database_name::String="", table_name::String="",
                debug::Bool=false, use_cache::Bool=true)
    rt.install_mysql(dataset, user, password, host, port, database_name,
                     table_name, debug, use_cache)

end

"""
```julia
    install_postgres(dataset; user::String="postgres",
                password::String="", host::String="localhost",
                port::Int=5432, database::String="postgres",

                database_name::String="", table_name::String="", compile::Bool=false,

                debug::Bool=false, quite::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in database.
"""
function install_postgres(dataset; user::String="postgres",
                password::String="", host::String="localhost",
                port::Int=5432, database::String="postgres",

                database_name::String="", table_name::String="",
                debug::Bool=false, use_cache::Bool=true)
    rt.install_postgres(dataset, user, password, host, port, database,
                        database_name, table_name, debug, use_cache)

end

"""
```julia

    install_sqlite(dataset; file::String="", table_name::String="",

                compile::Bool=false, debug::Bool=false, quite::Bool=false,
                use_cache::Bool=true)
```

Install Retriever scripts in database.
"""

function install_sqlite(dataset; file::String="", table_name::String="",
                debug::Bool=false,
                use_cache::Bool=true)
    rt.install_sqlite(dataset, file, table_name, debug,

                      use_cache)
end

"""
```julia

    install_msaccess(dataset; file::String="", table_name::String="",

                compile::Bool=false, debug::Bool=false, quite::Bool=false,
                use_cache::Bool=true)
```


Install Retriever scripts in msacces.
"""

function install_msaccess(dataset; file::String="", table_name::String="",
                debug::Bool=false,

                use_cache::Bool=true)
    rt.install_msaccess(dataset, file, table_name, compile, debug, quite,
                        use_cache)
end

"""
```julia

    install_json(dataset; table_name::String="", compile::Bool=false,

            debug::Bool=false, quite::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in json format.
"""

function install_json(dataset; table_name::String="",
                debug::Bool=false, use_cache::Bool=true)
    rt.install_json(dataset, table_name, debug, use_cache)

end

"""
```julia

    install_xml(dataset; table_name::String="", compile::Bool=false,

            debug::Bool=false, quite::Bool=false, use_cache::Bool=true)
```

Install Retriever scripts in xml format.
"""

function install_xml(dataset; table_name::String="",
                debug::Bool=false, use_cache::Bool=true)
    rt.install_xml(dataset, table_name, debug, use_cache)

end

"""
```julia
    reset_retriever(; scope::String="all")
```

Remove stored information on scripts, data, and connection
"""
function reset_retriever(; scope::String="all")
    rt.reset_retriever(scope)
end

end # module
