From CategoryTheory.Common Require Import Category.

Class Bifunctor {C D E : Category} : Type := {
  bobj : @obj C -> @obj D -> @obj E;
  bimap :
    forall {a c : @obj C} {b d : @obj D},
    hom a c -> hom b d -> hom (bobj a b) (bobj c d);
}.

Definition Type_compose {a b c : Type} (f : b -> c) (g : a -> b) : a -> c := fun x => f (g x).
Definition Type_id {a : Type} : a -> a := fun x => x.

Lemma Type_compose_assoc :
  forall {a b c d : Type} (f : c -> d) (g : b -> c) (h : a -> b),
    Type_compose f (Type_compose g h) = Type_compose (Type_compose f g) h.
Proof.
  trivial.
Qed.

Lemma Type_id_unit_left :
  forall {a b : Type} (f : a -> b), Type_compose Type_id f = f.
Proof.
  trivial.
Qed.

Lemma Type_id_unit_right :
  forall {a b : Type} (f : a -> b), Type_compose f Type_id = f.
Proof.
  trivial.
Qed.

Instance Type_Category : Category := {
  obj := Type;
  hom := fun A : Type => fun B : Type => (A -> B);
  id := @Type_id;
  compose := @Type_compose;

  compose_assoc := @Type_compose_assoc;
  id_unit_left := @Type_id_unit_left;
  id_unit_right := @Type_id_unit_right;
}.

Instance Product_Bifunctor : @Bifunctor Type_Category Type_Category Type_Category := {
  bobj := prod;
  bimap {a c : Type} {b d : Type} (f : a -> c) (g : b -> d) (p : prod a b) :=
    match p with pair x y => pair (f x) (g y) end;
}.
