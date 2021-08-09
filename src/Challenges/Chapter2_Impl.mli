
type 'a box = 'a __box Lazy.t
and 'a __box =
| Make_box of 'a

type 'a stream = 'a __stream Lazy.t
and 'a __stream =
| Cons of 'a box * 'a stream

val make_stream : (int -> 'a1) -> 'a1 stream

val stream_nth : 'a1 stream -> int -> 'a1

val memoize : (int -> 'a1) -> int -> 'a1
