module Model exposing (..)

import Message exposing (Msg)
import GetWords exposing (getWords)
import Dictionary exposing (Dictionary(..))


type alias Model =
    { insertSpaces : Bool
    , satisfyPwRules : Bool
    , avoidNordicCharacters : Bool
    , numberOfWords : Int
    , passphraseIndexes : List Int
    , words : List String
    , language : String
    , dictionary : Dictionary
    }


-- init : Maybe Model -> ( Model, Cmd Msg )
-- init mayModel =
init : ( Model, Cmd Msg )
init = ( { insertSpaces = True
         , satisfyPwRules = False
         , avoidNordicCharacters = False
         , numberOfWords = 4
         , passphraseIndexes = [ 0, 1, 2 ]
         , words = [ "Vennligst", "vent", "..." ]
         , dictionary = ProgrammingBooks
         , language = "en"
         }
       , getWords ProgrammingBooks
       )
-- init mayModel =
--     case mayModel of
--         Just model ->
--             ( { model
--                 | words = [ "Vennligst", "vent", "..." ]
--                 , passphraseIndexes = [ 0, 1, 2 ]
--               }
--             , getWords model.dictionary
--             )
-- 
--         Nothing ->
--             ( { insertSpaces = True
--               , satisfyPwRules = False
--               , avoidNordicCharacters = False
--               , numberOfWords = 4
--               , passphraseIndexes = [ 0, 1, 2 ]
--               , words = [ "Vennligst", "vent", "..." ]
--               , dictionary = ProgrammingBooks
--               , language = "en"
--               }
--             , getWords ProgrammingBooks
--             )
