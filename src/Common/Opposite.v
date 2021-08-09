Require Import CategoryTheory.Common.Category.

Definition Opposite (C : Category) : Category :=
  {|
    obj := @obj C;
    hom := fun a b => hom b a;
    id := fun c => @id C c;
    compose := fun a b c f g => @compose C c b a g f;
    compose_assoc := fun _ _ _ _ f g h => eq_sym (compose_assoc h g f);
    id_unit_left := fun _ _ f => @id_unit_right C _ _ f;
    id_unit_right := fun _ _ f => @id_unit_left C _ _ f;
  |}.

