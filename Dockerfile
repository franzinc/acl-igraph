ARG base_image

FROM ${base_image}
LABEL maintainer="Tianyu Gu <gty@franz.com>"

RUN set -eux; \
    \
    echo "Installing system dependencies"; \
    dnf install --enablerepo=devel --quiet -y \
        cmake \
        ninja-build \
        xz \
        gcc \
        gcc-c++

ARG igraph_version
RUN set -eux; \
    \
    echo "Dowloading igraph (${igraph_version})"; \
    curl -L https://github.com/igraph/igraph/releases/download/${igraph_version}/igraph-${igraph_version}.tar.gz | tar -C /usr/local/src -xz

RUN set -eux; \
    \
    echo "Building igraph (${igraph_version})"; \
    cd /usr/local/src/igraph-${igraph_version}; \
    cmake -B build -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        -DIGRAPH_USE_INTERNAL_BLAS=ON \
        -DIGRAPH_USE_INTERNAL_LAPACK=ON \
        -DIGRAPH_USE_INTERNAL_ARPACK=ON \
        -DIGRAPH_USE_INTERNAL_GLPK=ON \
        -DIGRAPH_USE_INTERNAL_GMP=ON \
        -DIGRAPH_USE_INTERNAL_PLFIT=ON \
        -DIGRAPH_GLPK_SUPPORT=ON \
        -DIGRAPH_GRAPHML_SUPPORT=OFF \
        -DIGRAPH_OPENMP_SUPPORT=ON \
        -DIGRAPH_ENABLE_LTO=ON \
        -DIGRAPH_ENABLE_TLS=ON; \
    cmake --build build/ --parallel 4; \
    cmake --build build/ --target check --parallel 4; \
    cmake --install build

COPY c/wrapper.c c/grovel.c /usr/local/src/
RUN set -eux; \
    \
    cd /usr/local/src; \
    gcc -g -Wall -c grovel.c -o grovel.o; \
    gcc grovel.o -ligraph -o /usr/local/bin/igraph-grovel; \
    rm grovel.o

VOLUME /dist
CMD igraph-grovel >/dist/grovel.cl && \
    gcc -shared -O3 -fPIC /usr/local/src/wrapper.c \
        -o ./dist/libigraph_lite.so \
        -Wl,--whole-archive /usr/local/lib64/libigraph.a \
        -Wl,--no-whole-archive -lgomp -lpthread -lstdc++ -lm -lgcc_s -lc
