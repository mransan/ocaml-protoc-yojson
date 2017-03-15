type json = Yojson.Basic.json 
(** type alias for the Yojson type used throughout this library *)

(** Protobuf Runtime signature with Yojson type *)
module type Encoder_sig = Pbrt_json.Encoder_sig 
  with type t = (string * json) list ref

(** Encoder module to implement the required signature from Pbrt_json with
    extra function to make it easier to use *)
module Encoder : sig 
  include Encoder_sig 

  val to_json : t -> json
  (** [to_json encoder] returns the Yojson value of the encoder *)

end

(** Protobuf Runtime signature with Yojson type *)
module type Decoder_sig = Pbrt_json.Decoder_sig 
  with type t = (string * json) list ref 

(** Encoder module to implement the required signature from Pbrt_json with
    extra function to make it easier to use *)
module Decoder : sig 
  include Decoder_sig

  val of_json : json -> t option
  (** [of_json json] returns an encoder value from a Yojson value. If the 
      Yojson value is not a JSON object then [None] is returned since 
      protobuf serialization always starts with an object (ie protobuf 
      message) *)

  val of_string : string -> t option 
  (** [of_string s] returns an encoder from a JSON string. [None]
      if an error occured or the JSON value is not an object. 
      
      This is just provided as a convenience, not that a lot of error 
      details are not exposed. For more details use Yojson functions
      directly. *)
end
