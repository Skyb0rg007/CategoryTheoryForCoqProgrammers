
Class Category : Type := {
  obj : Type;
  hom : obj -> obj -> Type;

  id : forall {a : obj}, hom a a;
  compose : forall {a b c : obj}, hom b c -> hom a b -> hom a c;

  compose_assoc :
    forall {a b c d : obj} (f : hom c d) (g : hom b c) (h : hom a b),
    compose f (compose g h) = compose (compose f g) h;

  id_unit_left :
    forall {a b : obj} (f : hom a b),
    compose id f = f;

  id_unit_right :
    forall {a b : obj} (f : hom a b),
    compose f id = f;
}.

#[refine] Instance TypeCategory : Category := {
  obj := Type;
  hom := fun a b => a -> b;
  id := fun a => fun x : a => x;
  compose := fun a b c => fun (f : b -> c) (g : a -> b) (x : a) => f (g x);
}.
Proof. trivial. trivial. trivial. Qed.

Require Import Coq.Classes.RelationClasses.

Program Instance EqualityCategory : Category := {
  obj := Type;
  hom := fun a b => a = b;
  id := @eq_refl Type;
  compose := fun (a b c : Type) (f : b = c) (g : a = b) => eq_trans g f;
}.
