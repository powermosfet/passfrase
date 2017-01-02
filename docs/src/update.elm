port module Update exposing (..)

import Http
import Random exposing (int, list)
import Message exposing (Msg(..))
import Model exposing (Model, Preferences, preferencesToValue)
import GetWords exposing (getWords)
import Platform.Cmd as Cmd exposing (batch)
import Json.Encode exposing (Value, encode)


port setStorage : Value -> Cmd msg


generateIndexes : Model -> ( Model, Cmd Msg )
generateIndexes model =
    let
        maxIndex =
            List.length model.words - 1
    in
        ( model
        , batch
            [ Random.generate NewIndexes (list model.preferences.numberOfWords (int 0 maxIndex))
            , model.preferences
                |> preferencesToValue
                |> setStorage
            ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        prf =
            model.preferences
    in
        case msg of
            ToggleSpaces ->
                generateIndexes { model | preferences = { prf | insertSpaces = not prf.insertSpaces } }

            TogglePwRules ->
                generateIndexes { model | preferences = { prf | satisfyPwRules = not prf.satisfyPwRules } }

            ToggleAvoidNordicCharacters ->
                generateIndexes { model | preferences = { prf | avoidNordicCharacters = not prf.avoidNordicCharacters } }

            ChangeNumberOfWords strN ->
                let
                    n =
                        Result.withDefault 0 (String.toInt strN)
                in
                    generateIndexes { model | preferences = { prf | numberOfWords = n } }

            NewIndexes indexes ->
                ( { model | passphraseIndexes = indexes }, Cmd.none )

            NewWords (Err _) ->
                ( model, getWords prf.dictionary )

            NewWords (Ok words) ->
                generateIndexes { model | words = words }

            NewPassphrase ->
                generateIndexes model

            ChangeLanguage language ->
                generateIndexes { model | preferences = { prf | language = language } }

            ChangeDictionary dictionary ->
                ( { model | preferences = { prf | dictionary = dictionary } }, getWords dictionary )
