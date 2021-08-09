From Coq Require Import Program.Basics Lists.List.

(* 1. No - doesn't preserve fmap id law *)

Definition fmap_bad {A B} (_ : A -> B) (_ : option A) : option B := None.

Definition id {A} (a : A) : A := a.

Lemma FmapBadBad :
  exists (A : Type) (m : option A),
  @fmap_bad A A id m <> id m.
Proof.
  intros.
  exists nat.
  exists (Some 1).
  replace (fmap_bad id (Some 1)) with (@None nat).
  - unfold id.
    discriminate.
  - trivial.
Qed.

(* 2 + 3. Reader functor and proof *)

Class Functor (F : Type -> Type) := {
  fmap : forall {A B : Type} (f : A -> B), F A -> F B;
  fmap_id : forall (A : Type) (x : F A), fmap id x = id x;
  fmap_compose : forall (A B C : Type) (f : A -> B) (g : B -> C) (x : F A),
    compose (fmap g) (fmap f) x = fmap (compose g f) x;
}.

Definition Reader (R : Type) : Type -> Type := fun A : Type => R -> A.

Definition Reader_fmap {R A B} (f : A -> B) (g : Reader R A) : Reader R B :=
  fun r : R => f (g r).

Lemma Reader_fmap_id :
  forall (R A : Type) (x : Reader R A),
  Reader_fmap id x = id x.
Proof.
  trivial.
Qed.

Lemma Reader_fmap_compose :
  forall (R A B C : Type) (f : A -> B) (g : B -> C) (x : Reader R A),
  Reader_fmap (compose g f) x = compose (Reader_fmap g) (Reader_fmap f) x.
Proof.
  trivial.
Qed.

Instance Reader_Functor (R : Type) : Functor (Reader R) := {
  fmap := @Reader_fmap R;
  fmap_id := Reader_fmap_id R;
  fmap_compose := Reader_fmap_compose R;
}.

(* 4. Prove the functor laws for the list functor. *)


Lemma List_fmap_compose :
  forall (A B C : Type) (f : A -> B) (g : B -> C) (x : list A),
  compose (map g) (map f) x = map (compose g f) x.
Proof.
  intros.
  symmetry.
  induction x.
  - trivial.
  - simpl.
    unfold compose at 1 3.
    rewrite -> (map_cons f _ _).
    rewrite -> (map_cons g _ _).
    rewrite -> IHx.
    trivial.
Qed.

Lemma List_fmap_id :
  forall (A : Type) (x : list A),
  map id x = id x.
Proof.
  intros.
  induction x.
  - trivial.
  - rewrite -> (map_cons id _ _).
    rewrite -> IHx.
    unfold id.
    trivial.
Qed.

Instance List_Functor : Functor list := {
  fmap := map;
  fmap_id := List_fmap_id;
  fmap_compose := List_fmap_compose;
}.

