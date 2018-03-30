
| **Documentation**                                                               | **PackageEvaluator**                                                                            | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url] |[![][license-img]][license-url]   | [![][travis-img]][travis-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-stable-url]: https://weecology.github.io/Retriever.jl/latest/
[docs-latest-img]: https://readthedocs.org/projects/retrieverjl/badge/?version=latest
[docs-latest-url]: https://weecology.github.io/Retriever.jl/latest/
[travis-img]: https://travis-ci.org/weecology/Retriever.jl.svg?branch=master
[travis-url]: https://travis-ci.org/weecology/Retriever.jl
[license-img]: http://img.shields.io/badge/license-MIT-blue.svg
[license-url]: https://raw.githubusercontent.com/weecology/Retriever.jl/master/LICENSE


# Retriever
Julia wrapper for the Data Retriever software.

Data Retriever automates the tasks of finding, downloading, 
and cleaning up publicly available data, and then stores them in a local database or as .csv files. 
Simply put, it's a package manager for data. 
This allows data analysts to spend a majority of their time in analysing rather than in cleaning up or managing data.

## Installation

To use Retriever, you first need to [install Retriever](http://www.data-retriever.org), a core python package.

To install Retriever using the Julia package manager


```julia

    julia> Pkg.add("Retriever")

```

To install from Source, download or checkout the source from the [github page](https://github.com/weecology/Retriever.jl.git).

Go to `Retriever.jl/src`. Run Julia.

```julia

    julia> include("Retriever.jl")

```

To create docs

```
$julia --color=yes make.jl

```

or simply

```

$julia make.jl

```
(Note: If you want help in installing Julia you can follow this [tutorial](https://medium.com/@shivamnegi2019/julia-beginners-guide-part-1-a9c369128c78)
