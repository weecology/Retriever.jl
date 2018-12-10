#!/bin/sh
set -e
#cp -r /cli_tools/.*  ~/
cp -r /Retriever.jl/cli_tools/.pgpass  ~/
cp -r /Retriever.jl/cli_tools/.my.cnf  ~/
exec "$@"