module GetWords exposing (..)

import Http
import Json.Decode as JSON
import Dictionary exposing (..)
import Message exposing (Msg(..))


getWords : Dictionary -> Cmd Msg
getWords dict =
    Http.send NewWords (Http.get (getUrl dict) parseWords)


parseWords : JSON.Decoder (List String)
parseWords =
    JSON.list JSON.string
