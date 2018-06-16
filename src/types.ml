open Sexplib.Conv

type repo =
  [ `Github of string * string
  | `Duniverse_fork of string
    (** [name] which is [https://github.com/dune-universe/name] *)
  | `None
  | `Unknown of string
  | `Virtual
  | `Error of string ]
[@@deriving sexp]

type opam =
  { name: string
  ; version: string
  ; dev_repo: repo
  ; tag: string option [@default None] [@sexp_drop_default]
  ; is_dune: bool [@default true] [@sexp_drop_default] }
[@@deriving sexp]

type packages = {pkgs: opam list} [@@deriving sexp]

let pp_sexp fn ppf v = Fmt.pf ppf "%s" (Sexplib.Sexp.to_string_hum (fn v))

let pp_repo = pp_sexp sexp_of_repo

let pp_opam = pp_sexp sexp_of_opam

let pp_packages = pp_sexp sexp_of_packages
