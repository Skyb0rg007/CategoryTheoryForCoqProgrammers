From Coq Require Import QArith.QArith.

Inductive partial A B :=
  | make_partial : (A -> option B) -> partial A B.

Definition id {A B} (p : partial A B) : partial A B := p.

Definition compose {A B C} (g : partial B C) (f : partial A B) : partial A C :=
  make_partial A C (fun x : A =>
  match g with make_partial _ _ g1 =>
  match f with make_partial _ _ f1 =>
  match f1 x with
  | None => None
  | Some y => g1 y
  end end end).

Definition safe_reciprocal : partial Q Q :=
  make_partial Q Q (fun q =>
  if Qeq_bool q 0
  then None
  else Some (1 / q)).

Definition safe_root : partial Q Q :=
  make_partial Q Q (fun q =>
  let fix go (c : Q) (x0 : Q) (n : nat) :=
    match n with
    | O => x0
    | S n1 => go c (x0 * (1#2) + (c/x0)*(1#2)) n1
    end
  in if Qle_bool q 0
  then None
  else Some (go q (q / 2) 5%nat)).

Definition apply {A B} (p : partial A B) (x : A) : option B :=
  match p with
  | make_partial _ _ f => f x
  end.

Definition safe_root_reciprocal : partial Q Q :=
  compose safe_root safe_reciprocal.
