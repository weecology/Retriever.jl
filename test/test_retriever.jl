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


test_datasets = ["bird-size", "Iris"]

os_password = ""
if Sys.iswindows()
    os_password = "Password12!"
end

sqlite_opts = Dict("engine" => "sqlite",
                    "file" => "dbfile",
                    "table_name" => "dbtable")

postgres_opts =  Dict("engine" =>  "postgres",
                        "user" =>  "postgres",
                        "host" =>  "localhost",
                        "password" => os_password,
                        "port" =>  5432,
                        "database" =>  "testdb27",
                        "database_name" =>  "testschema2",
                        "table_name" => "{db}.{table}")

csv_opts = Dict("engine" =>  "csv",
                "table_name" => "{db}_{table}.csv")

mysql_opt = Dict("engine" =>  "mysql",
                "user" => "travis",
                "password"=>"",
                "host"=>"localhost",
                "port"=>3306,
                "database_name"=>"testdb",
                "table_name"=>"{db}.{table}")


json_opt = Dict("engine" =>  "json",
                "table_name" => "output_file.json")


xml_opt = Dict("engine" =>  "xml",
                "table_name" => "output_file.xml")



function setup()
    result 

end


function teardown()

end


function install_csv_engine(data_arg)
    try
      # Install dataset into CSV database
      Retriever.install_csv(data_arg, table_name=csv_opts["table_name"])
      
      # Test if file is empyt using size     
      # @test filesize(csv_opts["table_name"]) > 0
      return true
    catch
        return false
    end
end



my_tempdir = tempdir()
@test isdir(my_tempdir) == true

# function install_json_engine(data_arg)
#     try
#       # Install dataset into Json database
#       Retriever.install_json(data_arg, table_name=json_opt["table_name"])

#       # Test if file is empyt using size  
#       @test filesize(json_opt["table_name"]) > 0
#       return true
#     catch
#         return false
#     end
# end


# function install_mysql_engine(data_arg)
#     try
#       # Install dataset into mysql database
#       Retriever.install_mysql(data_arg, user = mysql_opt["user"], host=mysql_opt["host"], port = mysql_opt["port"], database_name =mysql_opt["database_name"], table_name = mysql_opt["table_name"])
      
#       # Fetch the first 3 row entries from the table
#       con = mysql_connect(data_arg, user = mysql_opt["user"], host=mysql_opt["host"], port = mysql_opt["port"], database_name =mysql_opt["database_name"])
#       table_n = mysql_opt["table_name"]
#       command = "SELECT * FROM $table_n"
#       dframe = mysql_execute(con, command)
#       mysql_disconnect(con)
#       print(dframe)
#       # Verify that 3 items are fetched
#       @ test size(dframe, 1) == 3
#       return true
#     catch
#         return false
#     end
# end


# function install_postgres_engine(data_arg)
#     try
#       # Install dataset into mysql database
#       Retriever.install_postgres(data_arg, user = postgres_opts["user"], host=postgres_opts["host"],port = postgres_opts["port"], database_name =postgres_opts["database_name"],table_name = postgres_opts["table_name"])
      
#       # Since posgtres's api is currently not stable,
#       # no test on data installed
#       return true
#     catch
#         return false
#     end
# end


# # function install_sqlite_engine(::String)
# function install_sqlite_engine(data_arg::String)
#     try
#       # Install dataset into SQLite database
#       Retriever.install_sqlite(data_arg, file=sqlite_opts["file"], table_name=sqlite_opts["table_name"])
      
#       # Fetch the first 3 entries in the table 
#       table_n = sqlite_opts["table_name"]
#       db = SQLite.DB(sqlite_opts["file"])
#       result = SQLite.query(db, "SELECT * FROM $table_n LIMIT 3")
      
#       # Verify that 3 items from the table were fetched
#       @ test size(result, 1) == 3
#       return true
#     catch
#         return false
#     end
# end


# function install_xml_engine(data_arg)

#     try
#       # Install dataset into xml database
#       Retriever.install_xml(data_arg, table_name=xml_opt["table_name"])
      
#       # Check if install file is empty
#       @test filesize(xml_opt["table_name"]) > 0
#       return true
#     catch
#         return false
#     end
# end


@testset "Regression" begin
    @test true
    for datset_n in test_datasets

        # Data DB test
        # @test true == install_mysql_engine(datset_n)
        # @test true == install_postgres_engine(datset_n)
        # @test true == install_sqlite_engine(datset_n)

        # File engines use a temporary directory for tests
        @test true == mktempdir() do dirname install_csv_engine(datset_n) end
        # @test true == mktempdir() do dirname install_json_engine(datset_n) end
        # @test true == mktempdir() do dirname install_xml_engine(datset_n) end
    end

end # @testset Regression
