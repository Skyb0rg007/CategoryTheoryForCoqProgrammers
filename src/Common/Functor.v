From CategoryTheory.Common Require Import Category.

Class Functor {C D : Category} : Type := {
  fobj : @obj C -> @obj D;
  fmap : forall {a b : @obj C}, hom a b -> hom (fobj a) (fobj b);

  fmap_id :
    forall {a : @obj C}, fmap (@id C a) = @id D (fobj a);
  fmap_compose :
    forall {a b c : @obj C} (f : hom a b) (g : hom b c),
    fmap (compose g f) = compose (fmap g) (fmap f);
}.
