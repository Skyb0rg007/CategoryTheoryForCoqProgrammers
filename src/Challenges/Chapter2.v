
(* 1. Define a higher-order function memoize *)
CoInductive box A : Type :=
| make_box : A -> box A.

CoInductive stream A : Type :=
| cons : box A -> stream A -> stream A.

Definition make_stream {A : Type} (f : nat -> A) : stream A :=
  let cofix go n := cons A (make_box A (f n)) (go (S n))
  in go 0.

Fixpoint stream_nth {A : Type} (s : stream A) (n : nat) : A :=
  match s with
  | cons _ hd tl =>
      match n with
      | 0 => match hd with
             | make_box _ x => x
             end
      | S n1 => stream_nth tl n1
      end
  end.

Definition memoize {A : Type} (f : nat -> A) : nat -> A :=
  let s := make_stream f
  in  stream_nth s.

Require Coq.extraction.Extraction.
Extract Inductive nat => "int"
  ["0" "(fun x -> x + 1)"]
  "(fun zero succ n -> if n = 0 then zero () else succ (n - 1))".
Extraction Language OCaml.
Extraction "src/Challenges/Chapter2_Impl.ml" memoize.
