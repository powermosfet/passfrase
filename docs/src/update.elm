module Update exposing (..)

import Http
import Random exposing (int, list)

import Message exposing (Msg(..))
import Model exposing (Model)
import GetWords exposing (getWords)

generateIndexes : Model -> (Model, Cmd Msg)
generateIndexes model =
  let
    maxIndex = List.length model.words - 1
  in 
    (model, Random.generate NewIndexes (list model.numberOfWords (int 0 maxIndex)))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleSpaces ->
      generateIndexes { model | insertSpaces = not model.insertSpaces }
    TogglePwRules ->
      generateIndexes { model | satisfyPwRules = not model.satisfyPwRules }
    ChangeNumberOfWords strN ->
      let
        n = case (String.toInt strN) of
          Err _ -> 0
          Ok x -> x
      in
        generateIndexes { model | numberOfWords = n }
    NewIndexes indexes ->
      ({ model | passphraseIndexes = indexes }, Cmd.none)
    NewWords (Err _) ->
      (model, getWords)
    NewWords (Ok words) ->
      generateIndexes { model | words = words }
    NewPassphrase ->
      generateIndexes model