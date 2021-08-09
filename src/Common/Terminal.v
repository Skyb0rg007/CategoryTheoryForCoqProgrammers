From CategoryTheory.Common Require Import Category.

Class Terminal (C : Category) : Type := {
  terminal : obj;
  terminal_morph : forall d : obj, hom d terminal;
  terminal_morph_unique : forall (d : obj) (f g : hom d terminal), f = g;
}.
