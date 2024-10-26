#include <igraph/igraph.h>

/* Error handling */
IGRAPH_EXPORT const char *igraph_wrapper_strerror(igraph_error_t err) {
  return igraph_strerror(err);
}

IGRAPH_EXPORT igraph_error_handler_t *
igraph_wrapper_get_error_handler_printignore() {
  return (igraph_error_handler_t *)igraph_error_handler_printignore;
}

IGRAPH_EXPORT igraph_error_handler_t *
igraph_wrapper_set_error_handler(igraph_error_handler_t *handler) {
  return igraph_set_error_handler(handler);
}

IGRAPH_EXPORT igraph_warning_handler_t *
igraph_wrapper_set_warning_handler(igraph_warning_handler_t *handler) {
  return igraph_set_warning_handler(handler);
}

IGRAPH_EXPORT igraph_fatal_handler_t *
igraph_wrapper_set_fatal_handler(igraph_fatal_handler_t *handler) {
  return igraph_set_fatal_handler(handler);
}

/* Random numbers */
IGRAPH_EXPORT igraph_error_t
igraph_wrapper_rng_init(igraph_rng_t *rng, const igraph_rng_type_t *type) {
  return igraph_rng_init(rng, type);
}

IGRAPH_EXPORT void igraph_wrapper_rng_destroy(igraph_rng_t *rng) {
  igraph_rng_destroy(rng);
}

IGRAPH_EXPORT const char *igraph_wrapper_rng_name(const igraph_rng_t *rng) {
  return igraph_rng_name(rng);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_rng_seed(igraph_rng_t *rng,
                                                     igraph_uint_t seed) {
  return igraph_rng_seed(rng, seed);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_rng_bits(const igraph_rng_t *rng) {
  return igraph_rng_bits(rng);
}

IGRAPH_EXPORT igraph_rng_t *igraph_wrapper_rng_default() {
  return igraph_rng_default();
}

IGRAPH_EXPORT void igraph_wrapper_rng_set_default(igraph_rng_t *rng) {
  igraph_rng_set_default(rng);
}

IGRAPH_EXPORT const igraph_rng_type_t *igraph_wrapper_rng_get_rngtype_glibc2() {
  return &igraph_rngtype_glibc2;
}

IGRAPH_EXPORT const igraph_rng_type_t *
igraph_wrapper_rng_get_rngtype_mt19937() {
  return &igraph_rngtype_mt19937;
}

IGRAPH_EXPORT const igraph_rng_type_t *igraph_wrapper_rng_get_rngtype_pcg64() {
  return &igraph_rngtype_pcg64;
}

/* Graphs */
IGRAPH_EXPORT igraph_error_t igraph_wrapper_empty(igraph_t *graph,
                                                  igraph_integer_t n,
                                                  igraph_bool_t directed) {
  return igraph_empty(graph, n, directed);
}

IGRAPH_EXPORT void igraph_wrapper_destroy(igraph_t *graph) {
  igraph_destroy(graph);
}

IGRAPH_EXPORT igraph_integer_t igraph_wrapper_vcount(const igraph_t *graph) {
  return igraph_vcount(graph);
}

IGRAPH_EXPORT igraph_integer_t igraph_wrapper_ecount(const igraph_t *graph) {
  return igraph_ecount(graph);
}

IGRAPH_EXPORT int igraph_wrapper_is_directed(const igraph_t *graph) {
  return igraph_is_directed(graph) ? 1 : 0;
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_add_vertices(igraph_t *graph,
                                                         igraph_integer_t nv,
                                                         void *attr) {
  return igraph_add_vertices(graph, nv, attr);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_add_edges(
    igraph_t *graph, const igraph_vector_int_t *edges, void *attr) {
  return igraph_add_edges(graph, edges, attr);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_simplify(
    igraph_t *graph, igraph_bool_t remove_multiple, igraph_bool_t remove_loops,
    const igraph_attribute_combination_t *edge_comb) {
  return igraph_simplify(graph, remove_multiple, remove_loops, edge_comb);
}

/* Vector */
IGRAPH_EXPORT igraph_error_t igraph_wrapper_vector_init(igraph_vector_t *v,
                                                        igraph_integer_t size) {
  return igraph_vector_init(v, size);
}

IGRAPH_EXPORT void igraph_wrapper_vector_destroy(igraph_vector_t *v) {
  igraph_vector_destroy(v);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_vector_size(const igraph_vector_t *v) {
  return igraph_vector_size(v);
}

IGRAPH_EXPORT igraph_real_t igraph_wrapper_vector_get(igraph_vector_t *v,
                                                      igraph_integer_t pos) {
  return igraph_vector_get(v, pos);
}

IGRAPH_EXPORT void igraph_wrapper_vector_set(igraph_vector_t *v,
                                             igraph_integer_t pos,
                                             igraph_real_t value) {
  VECTOR(*v)[pos] = value;
}

IGRAPH_EXPORT igraph_real_t
igraph_wrapper_vector_sum(const igraph_vector_t *v) {
  return igraph_vector_sum(v);
}

IGRAPH_EXPORT void igraph_wrapper_vector_copy_to(igraph_vector_t *v,
                                                 igraph_real_t *to) {
  igraph_vector_copy_to(v, to);
}

IGRAPH_EXPORT void igraph_wrapper_vector_print(igraph_vector_t *v) {
  igraph_vector_print(v);
}

IGRAPH_EXPORT igraph_error_t
igraph_wrapper_vector_int_init(igraph_vector_int_t *v, igraph_integer_t size) {
  return igraph_vector_int_init(v, size);
}

IGRAPH_EXPORT void igraph_wrapper_vector_int_destroy(igraph_vector_int_t *v) {
  igraph_vector_int_destroy(v);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_vector_int_size(const igraph_vector_int_t *v) {
  return igraph_vector_int_size(v);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_vector_int_capacity(const igraph_vector_int_t *v) {
  return igraph_vector_int_capacity(v);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_vector_int_get(igraph_vector_int_t *v, igraph_integer_t pos) {
  return igraph_vector_int_get(v, pos);
}

IGRAPH_EXPORT void igraph_wrapper_vector_int_set(igraph_vector_int_t *v,
                                                 igraph_integer_t pos,
                                                 igraph_integer_t value) {
  VECTOR(*v)[pos] = value;
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_vector_int_push_back(
    igraph_vector_int_t *v, igraph_integer_t value) {
  return igraph_vector_int_push_back(v, value);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_vector_int_pop_back(igraph_vector_int_t *v) {
  return igraph_vector_int_pop_back(v);
}

IGRAPH_EXPORT void
igraph_wrapper_vector_int_resize_min(igraph_vector_int_t *v) {
  igraph_vector_int_resize_min(v);
}

IGRAPH_EXPORT void igraph_wrapper_vector_int_copy_to(igraph_vector_int_t *v,
                                                     igraph_integer_t *to) {
  igraph_vector_int_copy_to(v, to);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_vector_int_sum(igraph_vector_int_t *v) {
  return igraph_vector_int_sum(v);
}

IGRAPH_EXPORT void igraph_wrapper_vector_int_print(igraph_vector_int_t *v) {
  igraph_vector_int_print(v);
}

/* Stacks */
IGRAPH_EXPORT igraph_error_t igraph_wrapper_stack_int_init(
    igraph_stack_int_t *stack, igraph_integer_t capacity) {
  return igraph_stack_int_init(stack, capacity);
}

IGRAPH_EXPORT void igraph_wrapper_stack_int_destroy(igraph_stack_int_t *stack) {
  igraph_stack_int_destroy(stack);
}

IGRAPH_EXPORT int igraph_wrapper_stack_int_empty(igraph_stack_int_t *stack) {
  return igraph_stack_int_empty(stack) ? 1 : 0;
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_stack_int_push(
    igraph_stack_int_t *stack, igraph_integer_t item) {
  return igraph_stack_int_push(stack, item);
}

IGRAPH_EXPORT igraph_integer_t
igraph_wrapper_stack_int_pop(igraph_stack_int_t *stack) {
  return igraph_stack_int_pop(stack);
}

/* Adjacent lists */
IGRAPH_EXPORT igraph_error_t
igraph_wrapper_adjlist(igraph_t *graph, const igraph_adjlist_t *adjlist,
                       igraph_neimode_t mode, igraph_bool_t duplicate) {
  return igraph_adjlist(graph, adjlist, mode, duplicate);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_adjlist_init_empty(
    igraph_adjlist_t *al, igraph_integer_t no_of_nodes) {
  return igraph_adjlist_init_empty(al, no_of_nodes);
}

IGRAPH_EXPORT void igraph_wrapper_adjlist_destroy(igraph_adjlist_t *al) {
  igraph_adjlist_destroy(al);
}

IGRAPH_EXPORT igraph_error_t
igraph_wrapper_adjlist_simplify(igraph_adjlist_t *al) {
  return igraph_adjlist_simplify(al);
}

IGRAPH_EXPORT void igraph_wrapper_adjlist_print(const igraph_adjlist_t *al) {
  igraph_adjlist_print(al);
}

/* Vertex selectors */
IGRAPH_EXPORT igraph_error_t igraph_wrapper_vs_all(igraph_vs_t *vs) {
  return igraph_vs_all(vs);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_vs_adj(igraph_vs_t *vs,
                                                   igraph_integer_t vid,
                                                   igraph_neimode_t mode) {
  return igraph_vs_adj(vs, vid, mode);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_vs_nonadj(igraph_vs_t *vs,
                                                      igraph_integer_t vid,
                                                      igraph_neimode_t mode) {
  return igraph_vs_nonadj(vs, vid, mode);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_vs_none(igraph_vs_t *vs) {
  return igraph_vs_none(vs);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_vs_1(igraph_vs_t *vs,
                                                 igraph_integer_t vid) {
  return igraph_vs_1(vs, vid);
}

IGRAPH_EXPORT igraph_error_t
igraph_wrapper_vs_vector(igraph_vs_t *vs, const igraph_vector_int_t *v) {
  return igraph_vs_vector(vs, v);
}

IGRAPH_EXPORT void igraph_wrapper_vs_destroy(igraph_vs_t *vs) {
  igraph_vs_destroy(vs);
}

IGRAPH_EXPORT igraph_integer_t igraph_wrapper_vs_size(
    const igraph_t *graph, const igraph_vs_t *vs, igraph_integer_t *result) {
  return igraph_vs_size(graph, vs, result);
}

IGRAPH_EXPORT igraph_vs_type_t igraph_wrapper_vs_type(const igraph_vs_t *vs) {
  return igraph_vs_type(vs);
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_strength_vss_all(
    igraph_t *graph, igraph_vector_t *res, igraph_neimode_t mode,
    igraph_bool_t loops, const igraph_vector_t *weights) {
  return igraph_strength(graph, res, igraph_vss_all(), mode, loops, weights);
}

/* Centrality measures */
IGRAPH_EXPORT igraph_error_t igraph_wrapper_degree(const igraph_t *graph,
                                                   igraph_vector_int_t *res,
                                                   const igraph_vs_t *vids,
                                                   igraph_neimode_t mode,
                                                   igraph_bool_t loops) {
  if (vids == NULL) {
    return igraph_degree(graph, res, igraph_vss_all(), mode, loops);
  } else {
    return igraph_degree(graph, res, *vids, mode, loops);
  }
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_betweenness(
    const igraph_t *graph, igraph_vector_t *res, const igraph_vs_t *vids,
    igraph_bool_t directed, const igraph_vector_t *weights) {
  if (vids == NULL) {
    return igraph_betweenness(graph, res, igraph_vss_all(), directed, weights);
  } else {
    return igraph_betweenness(graph, res, *vids, directed, weights);
  }
}

IGRAPH_EXPORT igraph_error_t igraph_wrapper_closeness(
    const igraph_t *graph, igraph_vector_t *res,
    igraph_vector_int_t *reachable_count, igraph_bool_t *all_reachable,
    const igraph_vs_t *vids, igraph_neimode_t mode,
    const igraph_vector_t *weights, igraph_bool_t normalized) {
  if (vids == NULL) {
    return igraph_closeness(graph, res, reachable_count, all_reachable,
                            igraph_vss_all(), mode, weights, normalized);
  } else {
    return igraph_closeness(graph, res, reachable_count, all_reachable, *vids,
                            mode, weights, normalized);
  }
}

igraph_error_t
igraph_wrapper_pagerank(const igraph_t *graph, igraph_vector_t *vector,
                        igraph_real_t *value, const igraph_vs_t *vids,
                        igraph_bool_t directed, igraph_real_t damping,
                        const igraph_vector_t *weights) {
  // Using the PRPACK library. See also:
  // https://igraph.org/c/doc/igraph-Structural.html#igraph_pagerank_algo_t
  if (vids == NULL) {
    return igraph_pagerank(graph, 2, vector, value, igraph_vss_all(), directed,
                           damping, weights, 0);
  } else {
    return igraph_pagerank(graph, 2, vector, value, *vids, directed, damping,
                           weights, 0);
  }
}

igraph_real_t igraph_wrapper_centralization(const igraph_vector_t *scores,
                                            igraph_real_t theoretical_max,
                                            igraph_bool_t normalized) {
  return igraph_centralization(scores, theoretical_max, normalized);
}

igraph_error_t igraph_wrapper_centralization_degree(
    const igraph_t *graph, igraph_vector_t *res, igraph_neimode_t mode,
    igraph_bool_t loops, igraph_real_t *centralization,
    igraph_real_t *theoretical_max, igraph_bool_t normalized) {
  return igraph_centralization_degree(graph, res, mode, loops, centralization,
                                      theoretical_max, normalized);
}

igraph_error_t igraph_wrapper_centralization_betweenness(
    const igraph_t *graph, igraph_vector_t *res, igraph_bool_t directed,
    igraph_real_t *centralization, igraph_real_t *theoretical_max,
    igraph_bool_t normalized) {
  return igraph_centralization_betweenness(graph, res, directed, centralization,
                                           theoretical_max, normalized);
}

igraph_error_t igraph_wrapper_centralization_closeness(
    const igraph_t *graph, igraph_vector_t *res, igraph_neimode_t mode,
    igraph_real_t *centralization, igraph_real_t *theoretical_max,
    igraph_bool_t normalized) {
  return igraph_centralization_closeness(graph, res, mode, centralization,
                                         theoretical_max, normalized);
}

/* Community detection */
IGRAPH_EXPORT igraph_error_t igraph_wrapper_community_leiden(
    const igraph_t *graph, const igraph_vector_t *edge_weights,
    const igraph_vector_t *node_weights,
    const igraph_real_t resolution_parameter, const igraph_real_t beta,
    const igraph_bool_t start, const igraph_integer_t n_iterations,
    igraph_vector_int_t *membership, igraph_integer_t *nb_clusters,
    igraph_real_t *quality) {
  return igraph_community_leiden(
      graph, edge_weights, node_weights, resolution_parameter, beta, start,
      n_iterations, membership, nb_clusters, quality);
}

/* Non-graph related functions */
IGRAPH_EXPORT void igraph_wrapper_version(const char **version_string,
                                          int *major, int *minor,
                                          int *subminor) {
  igraph_version(version_string, major, minor, subminor);
}
