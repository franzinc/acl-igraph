;;;; ffi.cl
(in-package #:acl-igraph)

(eval-when (:compile-toplevel)
  (declaim (optimize (speed 3) (safety 1) (space 0) (debug 0))))

;;; C types
(def-foreign-type igraph_rng_type_t
    (:struct
     (name (* :char))
     (bits :unsigned-char)
     ;; initialization and destruction
     (init (* :void))
     (destroy (* :void))
     ;; seeding
     (seed (* :void))
     ;; fundamental generator:
     ;; return as many random bits as the RNG supports in a single round
     (get (* :void))
     ;; optional generators
     (get_int (* :void))
     (get_real (* :void))
     (get_norm (* :void))
     (get_geom (* :void))
     (get_binom (* :void))
     (get_gamma (* :void))
     (get_pois (* :void))))

(def-foreign-type igraph_rng_t
    (:struct
     (type igraph_rng_type_t)
     (state (* :void))
     (is_seeded igraph_bool_t)))

(def-foreign-type igraph_vector_t
    (:struct
     (stor_begin (* igraph_real_t))
     (stor_end (* igraph_real_t))
     (end (* igraph_real_t))))

(def-foreign-type igraph_vector_int_t
    (:struct
     (stor_begin (* igraph_integer_t))
     (stor_end (* igraph_integer_t))
     (end (* igraph_integer_t))))

(def-foreign-type igraph_stack_int_t
    (:struct
     (stor_begin (* igraph_integer_t))
     (stor_end (* igraph_integer_t))
     (end (* igraph_integer_t))))

(def-foreign-type igraph_t
    (:struct
     (n igraph_integer_t)
     (directed igraph_bool_t)
     (from igraph_vector_int_t)
     (to igraph_vector_int_t)
     (oi igraph_vector_int_t)
     (ii igraph_vector_int_t)
     (os igraph_vector_int_t)
     (is igraph_vector_int_t)
     (attr (* :void))
     (cache (* :void))))

(def-foreign-type igraph_adjlist_t
    (:struct
     (length igraph_integer_t)
     (adjs (* igraph_vector_int_t))))

(def-foreign-type igraph_vs_t
    (:struct
     (type igraph_vs_type_t)
     (:union
      (vid igraph_integer_t)
      (vecptr (* igraph_vector_int_t))
      (:struct
       (vid igraph_integer_t)
       (mode igraph_neimode_t))
      (:struct
       (start igraph_integer_t)
       (end igraph_integer_t)))))

;;; Error handling
(def-foreign-call (igraph_strerror "igraph_wrapper_strerror")
    ((igraph_errno igraph_error_t))
  :returning ((* :char))
  :strings-convert t
  :arg-checking nil)

(def-foreign-call (igraph_get_error_handler_printignore "igraph_wrapper_get_error_handler_printignore")
    (:void)
  :returning :foreign-address
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_set_error_handler "igraph_wrapper_set_error_handler")
    ((handler (* :void)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_set_warning_handler "igraph_wrapper_set_warning_handler")
    ((handler (* :void)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_set_fatal_handler "igraph_wrapper_set_fatal_handler")
    ((handler (* :void)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Random numbers
(def-foreign-call (igraph_rng_init "igraph_wrapper_rng_init")
    ((rng (* igraph_rng_t))
     (type (* igraph_rng_type_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_destroy "igraph_wrapper_rng_destroy")
    ((rng (* igraph_rng_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_name "igraph_wrapper_rng_name")
    ((rng (* igraph_rng_t)))
  :returning ((* :char) simple-string)
  :strings-convert t
  :arg-checking nil)

(def-foreign-call (igraph_rng_seed "igraph_wrapper_rng_seed")
    ((rng (* igraph_rng_t))
     (seed igraph_uint_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_bits "igraph_wrapper_rng_bits")
    ((rng (* igraph_rng_t)))
  :returning igraph_uint_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_default "igraph_wrapper_rng_default")
    (:void)
  :returning ((* igraph_rng_t))
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_set_default "igraph_wrapper_rng_set_default")
    ((rng (* igraph_rng_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_get_rngtype_glibc2 "igraph_wrapper_rng_get_rngtype_glibc2")
    (:void)
  :returning ((* igraph_rng_type_t))
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_get_rngtype_mt19937 "igraph_wrapper_rng_get_rngtype_mt19937")
    (:void)
  :returning ((* igraph_rng_type_t))
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_rng_get_rngtype_pcg64 "igraph_wrapper_rng_get_rngtype_pcg64")
    (:void)
  :returning ((* igraph_rng_type_t))
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Graphs
(def-foreign-call (igraph_empty "igraph_wrapper_empty")
    ((graph (* igraph_t))
     (n igraph_integer_t)
     (directed igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_destroy "igraph_wrapper_destroy")
    ((graph (* igraph_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vcount "igraph_wrapper_vcount")
    ((graph (* igraph_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_ecount "igraph_wrapper_ecount")
    ((graph (* igraph_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_is_directed "igraph_wrapper_is_directed")
    ((graph (* igraph_t)))
  :returning :boolean
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_add_vertices "igraph_wrapper_add_vertices")
    ((graph (* igraph_t))
     (nv igraph_integer_t)
     (attr (* :void)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_add_edges "igraph_wrapper_add_edges")
    ((graph (* igraph_t))
     (edges (* igraph_vector_int_t))
     (attr (* :void)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Vectors
(def-foreign-call (igraph_vector_init "igraph_wrapper_vector_init")
    ((v (* igraph_vector_t))
     (size igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_destroy "igraph_wrapper_vector_destroy")
    ((v (* igraph_vector_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_size "igraph_wrapper_vector_size")
    ((v (* igraph_vector_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_get "igraph_wrapper_vector_get")
    ((v (* igraph_vector_t))
     (pos igraph_integer_t))
  :returning igraph_real_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_set "igraph_wrapper_vector_set")
    ((v (* igraph_vector_t))
     (pos igraph_integer_t)
     (value igraph_integer_t))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_sum "igraph_wrapper_vector_sum")
    ((v (* igraph_vector_t)))
  :returning igraph_real_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_copy_to "igraph_wrapper_vector_copy_to")
    ((v (* igraph_vector_t))
     (to (* igraph_real_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_print "igraph_wrapper_vector_print")
    ((v (* igraph_vector_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_init "igraph_wrapper_vector_int_init")
    ((v (* igraph_vector_int_t))
     (size igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_destroy "igraph_wrapper_vector_int_destroy")
    ((v (* igraph_vector_int_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_size "igraph_wrapper_vector_int_size")
    ((v (* igraph_vector_int_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_capacity "igraph_wrapper_vector_int_capacity")
    ((v (* igraph_vector_int_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_get "igraph_wrapper_vector_int_get")
    ((v (* igraph_vector_int_t))
     (pos igraph_integer_t))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_set "igraph_wrapper_vector_int_set")
    ((v (* igraph_vector_int_t))
     (pos igraph_integer_t)
     (value igraph_integer_t))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_push_back "igraph_wrapper_vector_int_push_back")
    ((v (* igraph_vector_int_t))
     (value igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_pop_back "igraph_wrapper_vector_int_pop_back")
    ((v (* igraph_vector_int_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_resize_min "igraph_wrapper_vector_int_resize_min")
    ((v (* igraph_vector_int_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_copy_to "igraph_wrapper_vector_int_copy_to")
    ((v (* igraph_vector_int_t))
     (to (* igraph_integer_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_sum "igraph_wrapper_vector_int_sum")
    ((v (* igraph_vector_int_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vector_int_print "igraph_wrapper_vector_int_print")
    ((v (* igraph_vector_int_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Stacks
(def-foreign-call (igraph_stack_int_init "igraph_wrapper_stack_int_init")
    ((stack (* igraph_stack_int_t))
     (capacity igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_stack_int_destroy "igraph_wrapper_stack_int_destroy")
    ((stack (* igraph_stack_int_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_stack_int_empty_p "igraph_wrapper_stack_int_empty")
    ((stack (* igraph_stack_int_t)))
  :returning :boolean
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_stack_int_push "igraph_wrapper_stack_int_push")
    ((stack (* igraph_stack_int_t))
     (value igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_stack_int_pop "igraph_wrapper_stack_int_pop")
    ((stack (* igraph_stack_int_t)))
  :returning igraph_integer_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Adjacency lists
(def-foreign-call (igraph_adjlist "igraph_wrapper_adjlist")
    ((graph (* igraph_t))
     (adjlist (* igraph_adjlist_t))
     (mode igraph_neimode_t)
     (duplicate igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_adjlist_init_empty "igraph_wrapper_adjlist_init_empty")
    ((adjlist (* igraph_adjlist_t))
     (no_of_nodes igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_adjlist_destroy "igraph_wrapper_adjlist_destroy")
    ((adjlist (* igraph_adjlist_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_adjlist_simplify "igraph_wrapper_adjlist_simplify")
    ((adjlist (* igraph_adjlist_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_adjlist_print "igraph_wrapper_adjlist_print")
    ((adjlist (* igraph_adjlist_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Vertex selectors
(def-foreign-call (igraph_vs_all "igraph_wrapper_vs_all")
    ((vs (* igraph_vs_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_adj "igraph_wrapper_vs_adj")
    ((vs (* igraph_vs_t))
     (vid igraph_integer_t)
     (mode igraph_neimode_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_nonadj "igraph_wrapper_vs_nonadj")
    ((vs (* igraph_vs_t))
     (vid igraph_integer_t)
     (mode igraph_neimode_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_none "igraph_wrapper_vs_none")
    ((vs (* igraph_vs_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_1 "igraph_wrapper_vs_1")
    ((vs (* igraph_vs_t))
     (vid igraph_integer_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_vector "igraph_wrapper_vs_vector")
    ((vs (* igraph_vs_t))
     (v (* igraph_vector_int_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_destroy "igraph_wrapper_vs_destroy")
    ((vs (* igraph_vs_t)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_size "igraph_wrapper_vs_size")
    ((graph (* igraph_t))
     (vs (* igraph_vs_t))
     (res (* igraph_integer_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_vs_type "igraph_wrapper_vs_type")
    ((vs (* igraph_vs_t)))
  :returning igraph_vs_type_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_strength_vss_all "igraph_wrapper_strength_vss_all")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (mode igraph_neimode_t)
     (loops igraph_bool_t)
     (weights (* igraph_vector_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil
  :pass-structs-by-value t)

;;; Centrality measures
(def-foreign-call (igraph_degree "igraph_wrapper_degree")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (vids (* igraph_vs_t))
     (mode igraph_neimode_t)
     (loops igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_betweenness "igraph_wrapper_betweenness")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (vids (* igraph_vs_t))
     (directed igraph_bool_t)
     (weights (* igraph_vector_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_closeness "igraph_wrapper_closeness")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (reachable_count (* igraph_vector_int_t))
     (all_reachable (* igraph_bool_t))
     (vids (* igraph_vs_t))
     (mode igraph_neimode_t)
     (weights (* igraph_vector_t))
     (normalized igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_page_rank "igraph_wrapper_page_rank")
    ((graph (* igraph_t))
     (vector (* igraph_vector_t))
     (value (* igraph_vector_t))
     (vids (* igraph_vs_t))
     (directed igraph_bool_t)
     (damping igraph_real_t)
     (weights (* igraph_vector_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_centralization "igraph_wrapper_centralization")
    ((scores (* igraph_vector_t))
     (theoretical_max igraph_real_t)
     (normalized igraph_bool_t))
  :returning igraph_real_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_centralization_degree "igraph_wrapper_centralization_degree")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (mode igraph_neimode_t)
     (loops igraph_bool_t)
     (centralization (* igraph_real_t))
     (theoretical_max (* igraph_real_t))
     (normalized igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_centralization_betweenness "igraph_wrapper_centralization_betweenness")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (directed igraph_bool_t)
     (centralization (* igraph_real_t))
     (theoretical_max (* igraph_real_t))
     (normalized igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

(def-foreign-call (igraph_centralization_closeness "igraph_wrapper_centralization_closeness")
    ((graph (* igraph_t))
     (res (* igraph_vector_t))
     (mode igraph_neimode_t)
     (centralization (* igraph_real_t))
     (theoretical_max (* igraph_real_t))
     (normalized igraph_bool_t))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Community detection
(def-foreign-call (igraph_community_leiden "igraph_wrapper_community_leiden")
    ((graph (* igraph_t))
     (edge_weights (* igraph_vector_t))
     (node_weights (* igraph_vector_t))
     (resolution_parameter igraph_real_t)
     (beta igraph_real_t)
     (start igraph_bool_t)
     (n_iterations igraph_integer_t)
     (membership (* igraph_vector_int_t))
     (nb_clusters (* igraph_integer_t))
     (quality (* igraph_real_t)))
  :returning igraph_error_t
  :strings-convert nil
  :call-direct t
  :arg-checking nil)

;;; Non-graph related functions
(def-foreign-call (igraph_version "igraph_wrapper_version")
    ((version_string (* (* :char)))
     (major (* :int))
     (minor (* :int))
     (subminor (* :int)))
  :returning :void
  :strings-convert nil
  :call-direct t
  :arg-checking nil)
