
(* $Id$ *)

(*i*)
open Names
open Libobject
open Summary
(*i*)

(* This module provides a general mechanism to keep a trace of all operations
   and to backtrack (undo) those operations. It provides also the section
   mechanism (at a low level; discharge is not known at this step). *)

type node = 
  | Leaf of obj
  | OpenedSection of string
  | ClosedSection of string * library_segment
  | FrozenState of Summary.frozen

and library_segment = (section_path * node) list

type library_entry = section_path * node


(*s Adding operations, and getting the current list of operations (most 
  recent ones coming first). *)

val add_leaf : identifier -> path_kind -> obj -> section_path
val add_anonymous_leaf : obj -> section_path

val contents_after : section_path option -> library_segment

val map_leaf : section_path -> obj

(*s Opening and closing a section. *)

val open_section : string -> section_path
val close_section : string -> unit

val make_path : identifier -> path_kind -> section_path
val cwd : unit -> string list
val is_section_p : section_path -> bool

val open_module : string -> unit
val export_module : unit -> library_segment


(*s Backtracking (undo). *)

val reset_to : section_path -> unit


(*s We can get and set the state of the operations (used in [States]). *)

type frozen

val freeze : unit -> frozen
val unfreeze : frozen -> unit

val init : unit -> unit
