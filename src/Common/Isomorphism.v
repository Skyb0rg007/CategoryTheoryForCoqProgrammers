From CategoryTheory.Common Require Import Category.

Record Isomorphism {C : Category} (a b : @obj C) : Type := {
  iso_to : hom a b;
  iso_from : hom b a;
  iso_left_inverse : compose iso_to iso_from = id;
  iso_right_inverse : compose iso_from iso_to = id;
}.
