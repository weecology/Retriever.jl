#!/usr/bin/env julia
# using Retriever
# using Pkg

# Postgress tests are not stable currently
# Pkg.clone("git://github.com/JuliaDB/DBI.jl")
# Pkg.clone("git://github.com/JuliaDB/PostgreSQL.jl")
# using PostgreSQL

using PyCall
using SQLite
using MySQL

Retriever.check_for_updates()

# Service host names 
# Use service names on travis as host names else localhost
if haskey(ENV, "ON_TRAVIS") == false
    pgdb = "pgdb"
    mysqldb = "mysqldb"
else
    pgdb = mysqldb = "localhost"
end 

test_datasets = ["bird-size", "Iris"]

os_password = "Password12!"
if Sys.iswindows()
    os_password = "Password12!"
end

sqlite_opts = Dict("engine" => "sqlite",
                    "file" => "dbfile",
                    "table_name" => "{db}.{table}")

postgres_opts =  Dict("engine" =>  "postgres",
                        "user" =>  "postgres",
                        "host" =>  pgdb,
                        "password" => os_password,
                        "port" =>  5432,
                        "database" =>  "testdb",
                        "database_name" =>  "testschema2",
                        "table_name" => "{db}.{table}")

csv_opts = Dict("engine" =>  "csv",
                "table_name" => "{db}_{table}.csv")

mysql_opt = Dict("engine" =>  "mysql",
                "user" => "travis",
                "password"=> os_password,
                "host"=> mysqldb,
                "port"=>3306,
                "database_name"=>"testdb",
                "table_name"=>"{db}.{table}")


json_opt = Dict("engine" =>  "json",
                "table_name" => "{db}_{table}.json")


xml_opt = Dict("engine" =>  "xml",
                "table_name" => "{db}_{table}.xml")



function setup()
    # result 
end

function teardown()
end

function empty_files(path, ext)
    for (root, dirs, files) in walkdir(path)
        for file in files
            relative_path = joinpath(root, file)
            if endswith(relative_path, ext)
                println(relative_path)
                @test filesize(relative_path) > 10 
            end
        end
    end
end

function install_csv_engine(data_arg)
    try
        mktempdir() do dir_tmp
            cd(dir_tmp) do
                    # Install dataset into Json database
                    Retriever.install_csv(data_arg, table_name=csv_opts["table_name"])
                    empty_files(dir_tmp, ".csv")
            end
        end
      return true
    catch
        return false
    end
end
 
my_tempdir = tempdir()
@test isdir(my_tempdir) == true

function install_json_engine(data_arg)
    try
        mktempdir() do dir_tmp
            cd(dir_tmp) do
                    # Install dataset into Json database
                    Retriever.install_json(data_arg, table_name=json_opt["table_name"])
                    empty_files(dir_tmp, ".json")
            end
        end
      return true
    catch
        return false
    end
end

function install_xml_engine(data_arg)
    try
        mktempdir() do dir_tmp
            cd(dir_tmp) do
                    # Install dataset into Json database
                    Retriever.install_xml(data_arg, table_name=xml_opt["table_name"])
                    empty_files(dir_tmp, ".xml")
            end
        end
      return true
    catch
        return false
    end
end

function install_mysql_engine(data_arg)
    try
      # Install dataset into mysql database
      Retriever.install_mysql(data_arg, user = mysql_opt["user"], host=mysql_opt["host"], port = mysql_opt["port"], database_name =mysql_opt["database_name"], table_name = mysql_opt["table_name"])
      
      # Fetch the first 3 row entries from the table
      con = mysql_connect(data_arg, user = mysql_opt["user"], password=mysql_opt["password"],  host=mysql_opt["host"], port = mysql_opt["port"], database_name =mysql_opt["database_name"])
      table_n = mysql_opt["table_name"]
      command = "SELECT * FROM $table_n"
      dframe = mysql_execute(con, command)
      mysql_disconnect(con)
      print(dframe)
      # Verify that 3 items are fetched
      @test size(dframe, 1) == 3
      return true
    catch
        return false
    end
end


function install_postgres_engine(data_arg::String)
    try
      # Install dataset into mysql database
      Retriever.install_postgres(data_arg, user = postgres_opts["user"], password=postgres_opts["password"], host=postgres_opts["host"], port = postgres_opts["port"], database_name =postgres_opts["database_name"], table_name = postgres_opts["table_name"])

      # Since posgtres's api is currently not stable,
      # no test on data installed
      return true
    catch
        return false
    end
end


# function install_sqlite_engine(::String)
function install_sqlite_engine(data_arg)
    try
        mktempdir() do dir_tmp
            cd(dir_tmp) do
                # Install dataset into SQLite database
                Retriever.install_sqlite(data_arg, file=sqlite_opts["file"], table_name=sqlite_opts["table_name"])
                
                # Fetch the first 3 entries in the table 
                # table_n = sqlite_opts["table_name"]
                # db = SQLite.DB(sqlite_opts["file"])
                # result = SQLite.query(db, "SELECT * FROM sqlite_master WHERE type = "table"")
                # i for i in r[1]]
                # # Verify a name similar to the dataset
                # @test size(result, 1) => 1
                return true
            end
        end
    catch
        return false
    end
end


@testset "Regression" begin
    @test true
    work_dir = pwd()
    for datset_n in test_datasets

        # Data DB test
        @test true == install_mysql_engine(datset_n)
        @test true == install_postgres_engine(datset_n)
        @test true == install_sqlite_engine(datset_n)

        # File engines use a temporary directory for tests
        @test true == install_csv_engine(datset_n)
        @test true == install_json_engine(datset_n)
        @test true == install_xml_engine(datset_n)
    end

end # @testset Regression
