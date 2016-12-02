module Model exposing (..)

import Message exposing (Msg)
import GetWords exposing (getWords)

type alias Model = 
  { insertSpaces : Bool
  , satisfyPwRules : Bool
  , numberOfWords : Int
  , passphraseIndexes : List Int
  , words: List String
  }

init : (Model, Cmd Msg)
init =
  ( { insertSpaces = True
    , satisfyPwRules = False
    , numberOfWords = 4
    , passphraseIndexes = []
    , words = []
    }
  , getWords
  )
