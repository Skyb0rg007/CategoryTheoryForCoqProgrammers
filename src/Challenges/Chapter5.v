From CategoryTheory.Common Require Import Category Terminal Isomorphism.

(* 1. Terminal objects are unique up to isomorphism *)
Lemma Terminals_isomorphic
  {C : Category} (t1 t2 : Terminal C) :
  Isomorphism (@terminal C t1) (@terminal C t2).
Proof.
  apply (Build_Isomorphism _ _ _ (terminal_morph _) (terminal_morph _)).
  apply terminal_morph_unique.
  apply terminal_morph_unique.
Qed.

(* 2. The product of two objects in a poset is their maximum *)
(* 3. The coproduct of two objects in a poset is their minimum *)

(* 4. Implement Either *)

Inductive either A B :=
  | Left : A -> either A B
  | Right : B -> either A B.

(* 5. Show that Either is a better coproduct than int with i and j *)
Definition inj_i_poor (n : nat) : nat := n.
Definition inj_j_poor (b : bool) : nat := if b then 0 else 1.

Definition m(e : either nat bool) : nat :=
  match e with
  | Left _ _ a => a
  | Right _ _ b => if b then 0 else 1
  end.

Lemma Either_is_better1 :
  forall (n : nat),
  inj_i_poor n = m (Left nat bool n).
Proof.
  trivial.
Qed.

Lemma Either_is_better2 :
  forall (b : bool),
  inj_j_poor b = m (Right nat bool b).
Proof.
  trivial.
Qed.

(* 6. The cardinality of int and bool are finite.
   Therefore you cannot pack additional information into int. *)

(* 7. INT_MAX-1 and INT_MIN are both mapped INT_MIN.
   Therefore there is no morphism from int to Either nat bool that factorizes Left and Right *)

(* 8. This datatype *)

Inductive these A B :=
  | This : A -> these A B
  | That : B -> these A B
  | These : A -> B -> these A B.

Definition these_to_either1 (t : these nat bool) : either nat bool :=
  match t with
  | This _ _ a => Left nat bool a
  | That _ _ b => Right nat bool b
  | These _ _ a _ => Left nat bool a
  end.

Definition these_to_either2 (t : these nat bool) : either nat bool :=
  match t with
  | This _ _ a => Left nat bool a
  | That _ _ b => Right nat bool b
  | These _ _ _ b => Right nat bool b
  end.

Lemma multiple_morphisms :
  exists t : these nat bool,
  these_to_either1 t <> these_to_either2 t.
Proof.
  set (p := These nat bool 0 false).
  now exists p.
Qed.



