#!/bin/sh
set -e

echo "\nJulia Version"
julia -e "versioninfo()"

echo "\nPython PATH:"
Which python

echo "\nRetriever PATH"
which retriever

echo "\n"

exec "$@"
