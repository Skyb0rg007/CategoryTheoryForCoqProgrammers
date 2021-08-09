
module Test(M : sig val f : int -> int end) = struct
    open M
    let f' = Chapter2_Impl.memoize f

    let run () =
        Printf.printf "No memoization \n";
        for n = 0 to 4 do
            for _ = 0 to 5 do
                Printf.printf "f %d #=> %d\n" n (f n)
            done
        done;
        Printf.printf "Memoized\n";
        for n = 0 to 4 do
            for _ = 0 to 5 do
                Printf.printf "f' %d #=> %d\n" n (f' n)
            done
        done
end

(* 2. Testing the memoization implementation on the Random module *)

let _ = Random.init 0

module Rand1 = Test(struct let f _ = Random.int 10 end)
let _ = Rand1.run ()

(* 3. Testing the memoization implementation on the Random module with seeds *)

module Rand2 = Test(struct let f seed = Random.init seed; Random.int 10 end)
let _ = Rand2.run ()
