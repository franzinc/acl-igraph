# acl-igraph: Allegro CL interface for igraph

## Description

`acl-igraph` is Allegro CL's interface for [*igraph*](https://igraph.org/) - a
collection of network analysis tools with the emphasis on efficiency,
portability and ease of use. The interface is implemented through Allegro's
[Foreign Function Interface](https://franz.com/support/documentation/11.0/foreign-functions.html)
and contains these components:

* C macro definitions, enums, and constants e.g. `+IGRAPH_SUCCESS+` (see
  [grovel.c](./c/grovel.c) and [grovel.cl](./src/grovel.cl))
* C types, including structs and typedefs (see [ffi.cl](./src/ffi.cl))
* C functions e.g. `igraph_is_directed` (see [wrapper.c](./c/wrapper.c) and
  [ffi.cl](./src/ffi.cl))

### ⚠ Note

* The bindings are not complete, although it's rather easy and straightforward
  to add more on demand.
* All C definitions are translated in a case-sensitive manner, therefore it's
  ideal to use [`mlisp`](https://franz.com/support/documentation/11.0/case.html#modern-mode-1)
  for loading this library.
* C source code can be automatically formatted if `clang-format` command is
  available. Currently, run `make .clang-format` will generate the corresponding
  configurations to [.clang-format](.clang-format) file.

## Installation

`acl-igraph` works on platforms where `igraph` is supported. Running `make` in
this directory will build `igraph` itself in a very portable way as well as
produce a shared library `libigraph_lite.so` in the end. Users can also modify
the way how `igraph` is compiled. To know more about how `igraph` is built e.g.
its dependencies, compiler options, please see
https://igraph.org/c/doc/igraph-Installation.html

Alternatively, `docker` can be used to build the C shared library in a
consistent building environment. [Dockerfile](./Dockerfile) has been added here
for future reference purpose. Currently, running `make docker` will build
`libigraph_lite.so` by using `docker` (or `podman`).

## License

Please refer to [LICENSE](./LICENSE).
