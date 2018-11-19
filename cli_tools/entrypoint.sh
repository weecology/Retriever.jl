#!/bin/sh
set -e

# copy config files to $HOME
cp -r /Retriever.jl/cli_tools/.pgpass  ~/
cp -r /Retriever.jl/cli_tools/.my.cnf  ~/

exec "$@"
