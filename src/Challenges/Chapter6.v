
(* 1. Show the isomorphism between Maybe a and Either () a *)
Definition MaybeToSum {A : Type} (m : option A) : unit + A :=
  match m with
  | None => inl tt
  | Some x => inr x
  end.

Definition SumToMaybe {A : Type} (e : unit + A) : option A :=
  match e with
  | inl tt => None
  | inr x => Some x
  end.

Lemma IdCompose1 :
  forall (A : Type) (m : option A),
  SumToMaybe (MaybeToSum m) = m.
Proof.
  intros.
  induction m.
  - cbn.
    trivial.
  - cbn.
    trivial.
Qed.

Lemma IdCompose2 :
  forall (A : Type) (m : unit + A),
  MaybeToSum (SumToMaybe m) = m.
Proof.
  intros.
  induction m.
  - cbn.
    destruct a.
    trivial.
  - cbn.
    trivial.
Qed.

(* 5. Show that a + a = 2 * a holds for types *)

Definition SumToProd {A : Type} (s : A + A) : bool * A :=
  match s with
  | inl a => (true, a)
  | inr a => (false, a)
  end.

Definition ProdToSum {A : Type} (p : bool * A) : A + A :=
  match p with
  | (true, a) => inl a
  | (false, a) => inr a
  end.

Lemma IdCompose3 :
  forall (A : Type) (s : A + A),
  ProdToSum (SumToProd s) = s.
Proof.
  intros.
  induction s.
  - cbn.
    trivial.
  - cbn.
    trivial.
Qed.

Lemma IdCompose4 :
  forall (A : Type) (p : bool * A),
  SumToProd (ProdToSum p) = p.
Proof.
  intros.
  destruct p.
  induction b.
  - cbn.
    trivial.
  - cbn.
    trivial.
Qed.
