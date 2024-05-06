##
# Allegro CL bindings for igraph
# @file
##

IGRAPH_VERSION=0.10.12

agraph_version_file = $(shell pwd)/../agraph/lisp/agraph-version
agraph_version_exists := $(shell test -f $(agraph_version_file) && echo yes)

ifeq ($(agraph_version_exists),yes)
AGVERSION ?= $(shell cat $(agraph_version_file))
else
$(error Cannot locate agraph-version file.)
endif

all: libigraph_lite.so

vendor/igraph:
	mkdir -p vendor
	curl -L https://github.com/igraph/igraph/releases/download/${IGRAPH_VERSION}/igraph-${IGRAPH_VERSION}.tar.gz | tar -C vendor -xz
	mv vendor/igraph-${IGRAPH_VERSION} vendor/igraph

igraph/lib/libigraph.a: vendor/igraph
	@cmake -S vendor/igraph -B vendor/igraph/build \
		-DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=$(shell pwd)/igraph \
		-DCMAKE_INSTALL_LIBDIR=lib \
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
        -DIGRAPH_ENABLE_TLS=ON
	@cmake --build vendor/igraph/build/ --parallel 2
	@cmake --build vendor/igraph/build/ --target check --parallel 2
	@cmake --install vendor/igraph/build

grovel.cl: igraph/lib/libigraph.a
	@gcc -g -Wall -c c/grovel.c -o c/grovel.o -Iigraph/include
	@gcc c/grovel.o -o c/igraph-grovel -Iigraph/include -ligraph -Ligraph/lib
	@c/igraph-grovel >grovel.cl

libigraph_lite.so:
	@if [ -f /fi/san1/disk1/acl-igraph/$(AGVERSION)/$@ ]; then \
		cp /fi/san1/disk1/acl-igraph/$(AGVERSION)/$@ .; \
	else \
		$(MAKE) igraph/lib/libigraph.a; \
		gcc --shared -O3 -fPIC c/wrapper.c -Iigraph/include \
			-o libigraph_lite.so \
			-Wl,--whole-archive igraph/lib/libigraph.a \
			-Wl,--no-whole-archive -lgomp -lpthread -lstdc++ -lm -lgcc_s -lc; \
		mkdir -p /fi/san1/disk1/acl-igraph/$(AGVERSION); \
		cp $@ /fi/san1/disk1/acl-igraph/$(AGVERSION); \
	fi

.clang-format:
	clang-format --style=GNU --sort-includes -dump-config >.clang-format

.PHONY: format
format: .clang-format
	@echo "Formatting C source files ... "
	@clang-format -i c/*
	@echo "Done."

DOCKER=podman
BASE_IMAGE=docker.io/rockylinux/rockylinux:8
BUILDER_IMAGE=igraph_builder

.PHONY: docker
docker:
	@$(DOCKER) build --build-arg base_image=$(BASE_IMAGE) \
		--build-arg igraph_version=$(IGRAPH_VERSION) \
		-t $(BUILDER_IMAGE) .
	@$(DOCKER) run --rm -v $(shell pwd):/dist $(BUILDER_IMAGE)
	cp libigraph_lite.so ../../agraph/

clean:
	find . -name "*.fasl" -delete
	rm -rf vendor igraph libigraph_lite.so c/*.o c/igraph-grovel
