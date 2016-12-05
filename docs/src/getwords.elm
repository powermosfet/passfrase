module GetWords exposing (..)

import Http
import Json.Decode as JSON

import Message exposing (Msg(..))

getWords : Cmd Msg
getWords =
    Http.send NewWords (Http.get "nrk.json" parseWords)

parseWords : JSON.Decoder (List String)
parseWords = JSON.list JSON.string
