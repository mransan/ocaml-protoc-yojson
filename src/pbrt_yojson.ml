open Yojson

type json = Basic.json 

module type Encoder_sig = 
    Pbrt_json.Encoder_sig with type t = (string * json) list ref

module Encoder = struct

  type t = (string * json) list ref 

  let empty () = ref [] 

  let set_null t key = 
    t := (key, `Null) :: !t 

  let set_string t key value = 
    t := (key, `String value) :: !t
  
  let set_float t key value = 
    t := (key, `Float value) :: !t
  
  let set_int t key value = 
    t := (key, `Int value) :: !t
  
  let set_bool t key value = 
    t := (key, `Bool value) :: !t
  
  let set_object t key value = 
    t := (key, `Assoc !value) :: !t

  let set_string_list t key value = 
    t := (key, `List (List.map (fun v -> `String v) value)) :: !t
  
  let set_float_list t key value = 
    t := (key, `List (List.map (fun v -> `Float v) value)) :: !t
  
  let set_int_list t key value = 
    t := (key, `List (List.map (fun v -> `Int v) value)) :: !t
  
  let set_bool_list t key value = 
    t := (key, `List (List.map (fun v -> `Bool v) value)) :: !t
  
  let set_object_list t key value = 
    t := (key, `List (List.map (fun v -> `Assoc !v) value)) :: !t

  let to_json t = 
    `Assoc !t
  
   let to_string t = 
     t |> to_json |> Basic.to_string
end 

module type Decoder_sig = 
  Pbrt_json.Decoder_sig with type t = (string * json) list ref 

module Decoder = struct 

  type t = (string * json) list ref 

  let of_json = function
    | `Assoc o -> Some (ref o) 
    | _ -> None 

  let of_string s = 
    try 
      Basic.from_string s |> of_json  
    with _ -> None
  
  type value = 
    | String of string 
    | Float of float 
    | Int of int 
    | Object of t 
    | Array_as_array of value array 
    | Bool of bool 
    | Null

  let rec map = function
    | `Null -> Null 
    | `Bool b -> Bool b 
    | `Int i -> Int i 
    | `Float f -> Float f 
    | `String s -> String s 
    | `Assoc a -> Object (ref a)
    | `List l -> Array_as_array (List.map map l |> Array.of_list)  

  let key t = 
    match !t with
    | [] -> None
    | (key, value)::tl -> begin
      t := tl; 
      Some (key, map value)
    end
end 
