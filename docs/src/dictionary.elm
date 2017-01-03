module Dictionary exposing (..)

import Json.Encode exposing (Value, bool, string, int)
import Json.Decode as Json
import Json.Decode exposing (andThen)


type Dictionary
    = Nrk
    | Erotics


getUrl : Dictionary -> String
getUrl dict =
    case dict of
        Nrk ->
            "nrk.json"

        Erotics ->
            "erotikk.json"


getDescription : Dictionary -> String
getDescription dict =
    case dict of
        Nrk ->
            "nrk.no"

        Erotics ->
            "noveller.no"


dictionaryToValue : Dictionary -> Value
dictionaryToValue dictionary =
    case dictionary of
        Nrk ->
            string "nrk"

        Erotics ->
            string "erotics"


dictionaryDecoder : String -> Json.Decoder Dictionary
dictionaryDecoder dictionary =
    case dictionary of
        "nrk" ->
            Json.succeed Nrk

        "erotics" ->
            Json.succeed Erotics

        _ ->
            Json.fail ("Could not parse dictionary " ++ dictionary)
