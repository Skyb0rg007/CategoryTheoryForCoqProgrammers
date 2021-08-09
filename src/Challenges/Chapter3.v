From Coq Require Import Bool.Bool.

(* 1.1. A graph with one node and no edges: *)
(* Add one edge from the node to itself *)
(* 1.2. A graph with one node and one directed edge: *)
(* Add each composition of the edge with itself, possibly infinitely *)
(* 1.3. A graph with two nodes and a single arrow between them: *)
(* Add an identity arrow on each node *)
(* 1.4. A graph with a single node and 26 arrows (marked a-z): *)
(* Add an identity arrow and every combination of arrow compositions.
   (What this may be looking for is "add an arrow for each string") *)

(* 2.1. A set with the inclusion relation: *)
(* partial order ({1} ⊈ {2} and {2} ⊈ {1}) *)
(* 2.2. C++ types, where T1 <= T2 iff std::is_convertible<T1 *, T2 *> *)
(* partial order (char * and int * are not convertible with each other) *)

(* 3. Show that bool forms two monoids with respect to && and || *)
Inductive Assoc {A : Type} (f : A -> A -> A) :=
  | Assoc_proof : (forall a b c : A, f a (f b c) = f (f a b) c) -> Assoc f.

Inductive IdElem {A : Type} (f : A -> A -> A) (id : A) :=
  | IdElem_proof : (forall a : A, f id a = a) -> (forall a : A, f a id = a) -> IdElem f id.

Inductive Monoid {A : Type} (f : A -> A -> A) (id : A) :=
  | Monoid_proof : Assoc f -> IdElem f id -> Monoid f id.

Definition AndMonoid : Monoid andb true :=
  Monoid_proof andb true
  (Assoc_proof andb andb_assoc)
  (IdElem_proof andb true andb_true_l andb_true_r).

Definition OrMonoid : Monoid orb false :=
  Monoid_proof orb false
  (Assoc_proof orb orb_assoc)
  (IdElem_proof orb false orb_false_l orb_false_r).

(* 4. Represent the bool && monoid as a category *)
(* object: bool
   morphisms:
   and true (true -> true, false -> false)
   and false (true -> false, false -> false)
 *)

(* 5. Represent addition modulo 3 as a category *)
(* object: number modulo 3
   morphisms:
   +0 (0 -> 0, 1 -> 1, 2 -> 2)
   +1 (0 -> 1, 1 -> 2, 2 -> 0)
   +2 (0 -> 2, 1 -> 0, 2 -> 1)
 *)
