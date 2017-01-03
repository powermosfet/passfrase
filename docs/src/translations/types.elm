module Translations.Types exposing (..)

import Json.Encode exposing (Value, bool, string, int)
import Json.Decode as Json
import Json.Decode exposing (andThen)


type Label
    = CurrentLanguage
    | Title
    | PleaseWait
    | NumberOfWords
    | Settings
    | InsertSpaces
    | SatisfyPwRules
    | AvoidNordicCharacters


type Language
    = Nor
    | Eng


languageToValue : Language -> Value
languageToValue lang =
    string <|
        case lang of
            Nor ->
                "no"

            Eng ->
                "en"


languageDecoder : String -> Json.Decoder Language
languageDecoder lang =
    case lang of
        "no" ->
            Json.succeed Nor

        "en" ->
            Json.succeed Eng

        _ ->
            Json.fail ("Could not parse language " ++ lang)
