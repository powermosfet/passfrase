module Internationalization exposing (..)

import Dict
import Maybe exposing (withDefault, andThen)
import Translations.Norwegian as Nor
import Translations.English as Eng


textMap =
    Dict.fromList
        [ ( "no", Nor.getText )
        , ( "en", Eng.getText )
        ]


getText lang label =
    let
        localTexts =
            Dict.get lang textMap

        englishTexts =
            Dict.get "en" textMap
    in
        withDefault
            (withDefault (toString label) (englishTexts |> andThen ((|>) label)))
            (localTexts |> andThen ((|>) label))
