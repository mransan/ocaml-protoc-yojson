[@@@ ocaml.warning "-48"]

open Message_pb 

let person = { 
  first_name = "John"; 
  last_name = "Doe";
  gender = Male;
  primary_residence = Some ( Appartment {
    floor_nb = 11l; 
    has_rooftop = false
  }); 
  secondary_residence = None; 
  height_in_meters = 1.75; 
  nb_of_children = 3; 
  status = (Some Not_married);
  record_id = 0x7AFAFAFAFAFAFAFAL;
  pets = [
    {type_ = Dog; name = "brutus"}; 
    {type_ = Cat; name = "miaou"}
  ];
} 

module JsonEncoder = Make_encoder(Pbrt_yojson.Encoder) 
module JsonDecoder = Make_decoder(Pbrt_yojson.Decoder)

let () = 
  let encoder = Pbrt_yojson.Encoder.empty () in 
  JsonEncoder.encode_person person encoder; 
  let json_str = 
    encoder 
    |> Pbrt_yojson.Encoder.to_json 
    |> Yojson.Basic.to_string 
  in
  print_endline "Json value:"; 
  print_endline json_str; 

  match Pbrt_yojson.Decoder.of_string json_str with
  | None -> assert(false) 
  | Some decoder -> 
    let person' = JsonDecoder.decode_person decoder in 
    assert(person' = person)
