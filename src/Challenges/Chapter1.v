
(* 1. Implement the identity function *)
Definition identity {A : Type} (x : A) : A := x.

(* 2. Implement the composition function *)
Definition compose {A B C : Type} (g : B -> C) (f : A -> B) : A -> C :=
  fun x : A => g (f x).

(* 3. Write a program that tests that composition respects identity *)
Lemma compose_identity :
  forall A B : Type,
  @compose A B B identity = identity.
Proof.
  trivial.
Qed.

(* 4. Is the world-wide-web a category? Are links morphisms? *)
(* No, since a link from site A to site B and B to C doesn't imply a link from A to C *)

(* 5. Is Facebook a category, with people as objects and friendships as morphisms? *)
(* No, since no one is one's own friend on Facebook *)

(* 6. When is a directed graph a category? *)
(* When it respects composition and identity:
   all objects point to themselves and an edge A->B and B->C implies an edge A->C *)
