
type 'a box = 'a __box Lazy.t
and 'a __box =
| Make_box of 'a

type 'a stream = 'a __stream Lazy.t
and 'a __stream =
| Cons of 'a box * 'a stream

(** val make_stream : (int -> 'a1) -> 'a1 stream **)

let make_stream f =
  let rec go n =
    lazy (Cons ((lazy (Make_box (f n))), (go ((fun x -> x + 1) n))))
  in go 0

(** val stream_nth : 'a1 stream -> int -> 'a1 **)

let rec stream_nth s n =
  let Cons (hd, tl) = Lazy.force s in
  ((fun zero succ n -> if n = 0 then zero () else succ (n - 1))
     (fun _ -> let Make_box x = Lazy.force hd in x)
     (fun n1 -> stream_nth tl n1)
     n)

(** val memoize : (int -> 'a1) -> int -> 'a1 **)

let memoize f =
  let s = make_stream f in stream_nth s
