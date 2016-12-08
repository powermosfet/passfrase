module Model exposing (..)

import Message exposing (Msg)
import GetWords exposing (getWords)


type alias Model =
    { insertSpaces : Bool
    , satisfyPwRules : Bool
    , avoidNordicCharacters : Bool
    , numberOfWords : Int
    , passphraseIndexes : List Int
    , words : List String
    }


init : Maybe Model -> ( Model, Cmd Msg )
init mayModel =
    case mayModel of
        Just model ->
            ( { model
                | words = [ "Vennligst", "vent", "..." ]
                , passphraseIndexes = [ 0, 1, 2 ]
              }
            , getWords
            )

        Nothing ->
            ( { insertSpaces = True
              , satisfyPwRules = False
              , avoidNordicCharacters = False
              , numberOfWords = 4
              , passphraseIndexes = [ 0, 1, 2 ]
              , words = [ "Vennligst", "vent", "..." ]
              }
            , getWords
            )
