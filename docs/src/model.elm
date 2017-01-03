module Model exposing (..)

import Message exposing (Msg)
import GetWords exposing (getWords)
import Dictionary exposing (Dictionary(..), dictionaryToValue, dictionaryDecoder)
import Translations.Types exposing (Language(..), languageToValue, languageDecoder)
import Json.Encode exposing (Value, bool, string, int)
import Json.Decode as Json
import Json.Decode exposing (andThen)


type alias Preferences =
    { insertSpaces : Bool
    , satisfyPwRules : Bool
    , avoidNordicCharacters : Bool
    , numberOfWords : Int
    , language : Language
    , dictionary : Dictionary
    }


type alias Model =
    { preferences : Preferences
    , passphraseIndexes : List Int
    , words : List String
    }


init : Maybe Json.Value -> ( Model, Cmd Msg )
init encModel =
    let
        initPrefs =
            { insertSpaces = True
            , satisfyPwRules = False
            , avoidNordicCharacters = False
            , numberOfWords = 4
            , dictionary = Nrk
            , language = Eng
            }

        preferences =
            encModel
                |> Maybe.andThen
                    (Json.decodeValue preferencesDecoder
                        >> Result.toMaybe
                    )
                |> Maybe.withDefault initPrefs

        model =
            { preferences = preferences
            , passphraseIndexes = []
            , words = []
            }
    in
        ( model
        , getWords model.preferences.dictionary
        )


preferencesToValue : Preferences -> Value
preferencesToValue prf =
    Json.Encode.object
        [ ( "insertSpaces", bool prf.insertSpaces )
        , ( "satisfyPwRules", bool prf.satisfyPwRules )
        , ( "avoidNordicCharacters", bool prf.avoidNordicCharacters )
        , ( "numberOfWords", int prf.numberOfWords )
        , ( "language", languageToValue prf.language )
        , ( "dictionary", dictionaryToValue prf.dictionary )
        ]


preferencesDecoder : Json.Decoder Preferences
preferencesDecoder =
    Json.map6 Preferences
        (Json.field "insertSpaces" Json.bool)
        (Json.field "satisfyPwRules" Json.bool)
        (Json.field "avoidNordicCharacters" Json.bool)
        (Json.field "numberOfWords" Json.int)
        (Json.field "language" (Json.string |> andThen languageDecoder))
        (Json.field "dictionary" (Json.string |> andThen dictionaryDecoder))
