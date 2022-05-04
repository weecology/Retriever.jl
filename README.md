
| **Documentation**                                                               | **PackageEvaluator**                                                                            | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url] |[![][license-img]][license-url]   | [![][GitHub-Actions-img]][GitHub-Actions-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-stable-green.svg
[docs-stable-url]: https://weecology.github.io/Retriever.jl/stable/
[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://weecology.github.io/Retriever.jl/dev/
[GitHub-Actions-img]: https://github.com/weecology/Retriever.jl/actions/workflows/CI.yml/badge.svg
[GitHub-Actions-url]: https://github.com/weecology/Retriever.jl/actions/workflows/CI.yml
[license-img]: http://img.shields.io/badge/license-MIT-blue.svg
[license-url]: https://raw.githubusercontent.com/weecology/Retriever.jl/main/LICENSE

# Retriever

Julia wrapper for the Data Retriever software.

Data Retriever automates the tasks of finding, downloading,
and cleaning up publicly available data, and then stores them in a local database or as .csv files.
Simply put, it's a package manager for data.
This allows data analysts to spend a majority of their time in analysing rather than in cleaning up or managing data.

## Installation

### Deps
Python 3.7+
[PyCall](https://github.com/JuliaPy/PyCall.jl)
[Pkg](https://pkgdocs.julialang.org/v1/getting-started/) is needed and you can add packages using the `add` command or the `dev` command.
	pkg> add "git@github.com:JuliaPy/PyCall.jl.git
Julia 1.5+ is recommended

The Retriever.jl depends on a few Julia packages that will be installed automatically.

Ensure that Pycall is using the same Python path where the retriever Python package is installed.

You can change that path to a desired path as below.

```julia

julia> ENV["PYTHON"]="Python path where the retriever python package is installed"
# Build Pycall to enable the use of the new path
Pkg.build("PyCall")

```

Install the core Python [retriever](https://github.com/weecology/retriever) package.
In case your Python path is set, You can use `Pip install retriever` or
use PyCall to install the Python

```julia

# From release
packages = retriever
julia> run(`$(PyCall.pyprogramname) -m pip install --user -- $packages`)
# Or from current dev branch
julia> run(`$(PyCall.pyprogramname) -m pip install --user -- git+https://git@github.com/weecology/retriever.git`)

```

install Retriever Julia package

```julia

julia> Pkg.add("Retriever")

```

### Install from local Source

Download or checkout the source from the [github page](https://github.com/weecology/Retriever.jl.git).

Go to `Retriever.jl` directory and. Run Julia.

```Julia

julia> include("src/Retriever.jl")

```

Or use the [Pkg REPL](https://pkgdocs.julialang.org/v1/getting-started/)


```Julia

pkg> add PyCall
pkg> activate .
using Retriever

```

### Database Management Systems

Depending on the database management systems you wish to use, follow the `Setting up servers` [documentation of the retriever](https://retriever.readthedocs.io/en/latest/developer.html#setting-up-servers). You can change the credentials to suit your server settings.


## Example of installing the Datasets

```julia

# Using default parameter as the arguments
julia> Retriever.install_postgres("iris")
 # Passing user specfic arguments
julia> Retriever.install_postgres("iris", user = "postgres",
		password="Password12!", host="localhost", port=5432)

```

```julia

julia> Retriever.install_csv("iris")
julia> Retriever.install_mysql("iris")
julia> Retriever.install_sqlite("iris")
julia> Retriever.install_msaccess("iris")
julia> Retriever.install_json("iris")
julia> Retriever.install_xml("iris")

```

Creating docs.

To create docs, first refer to the
[Documenter docs](https://juliadocs.github.io/Documenter.jl/stable/man/guide).
To test doc locally run make.jl

```Shell

julia --color=yes make.jl

```

or simply

```Shell

julia make.jl

```

## Using Docker

To run tests using docker

`docker-compose run --service-ports retrieverj julia test/runtests.jl`

To run the image interactively

`docker-compose run --service-ports retrieverj /bin/bash`

To test docs in docker

` docker-compose run --service-ports retrieverj bash -c "cd docs && julia make.jl"`

Acknowledgments
---------------

Development of this software is funded by [the Gordon and Betty Moore
Foundation's Data-Driven Discovery
Initiative](http://www.moore.org/programs/science/data-driven-discovery) through
[Grant GBMF4563](http://www.moore.org/grants/list/GBMF4563) to Ethan White and
started as [Shivam Negi](https://www.linkedin.com/in/shivam-negi-64a227103/)'s [Google Summer of Code](https://summerofcode.withgoogle.com/)
