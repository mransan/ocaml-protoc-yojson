[@@@ ocaml.warning "-48"]

module Encoder = Pbrt_yojson.Encoder 
module Decoder = Pbrt_yojson.Decoder 

let () = 
  let t = Encoder.empty () in 
  Encoder.set_string t "name" "Maxime Ransan"; 
  Encoder.set_int t "age" 35; 
  Encoder.set_bool t "married" true;
(*  Encoder.set_int_list t "list" [1;2;3];*)

  let json_str = t |> Encoder.to_json |> Yojson.Basic.to_string in 

(*  print_endline json_str;*)
  let expected_json_str = 
    "{\"married\":true,\"age\":35,\"name\":\"Maxime Ransan\"}"
  in 

  assert(json_str = expected_json_str);

  let name = ref "" in 
  let age = ref (-1) in 
  let married = ref false in 

  let continue = ref true in 
  while !continue do 
    let open Decoder in
    match key t with
    | None -> continue := false
    | Some ("name", String s) -> name := s
    | Some ("name", _ ) -> assert(false)
    | Some ("age", Int i) -> age := i
    | Some ("age", Float f) -> age := int_of_float f
    | Some ("age", String s) -> age := int_of_string s
    | Some ("age", _) -> assert(false)
    | Some ("married", Bool b) -> married := b
    | Some ("married", _) -> assert(false)
    | Some _ -> () (* skip *)
  done;

  assert(!name = "Maxime Ransan"); 
  assert(!age = 35);
  assert(!married); 
  ()
