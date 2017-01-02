module Model exposing (..)

import Message exposing (Msg)
import GetWords exposing (getWords)
import Dictionary exposing (Dictionary(..))
import Json.Encode exposing (Value, bool, string, int)
import Json.Decode as Json
import Json.Decode exposing (andThen)


type alias Preferences =
    { insertSpaces : Bool
    , satisfyPwRules : Bool
    , avoidNordicCharacters : Bool
    , numberOfWords : Int
    , language : String
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
            , language = "en"
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
        , ( "language", string prf.language )
        , ( "dictionary", dictionaryToValue prf.dictionary )
        ]


dictionaryToValue : Dictionary -> Value
dictionaryToValue dictionary =
    case dictionary of
        Nrk ->
            string "nrk"

        Erotics ->
            string "erotics"


preferencesDecoder : Json.Decoder Preferences
preferencesDecoder =
    Json.map6 Preferences
        (Json.field "insertSpaces" Json.bool)
        (Json.field "satisfyPwRules" Json.bool)
        (Json.field "avoidNordicCharacters" Json.bool)
        (Json.field "numberOfWords" Json.int)
        (Json.field "language" Json.string)
        (Json.field "dictionary" (Json.string |> andThen dictionaryDecoder))


dictionaryDecoder : String -> Json.Decoder Dictionary
dictionaryDecoder dictionary =
    case dictionary of
        "nrk" ->
            Json.succeed Nrk

        "erotics" ->
            Json.succeed Erotics

        _ ->
            Json.fail ("Could not parse dictionary " ++ dictionary)
