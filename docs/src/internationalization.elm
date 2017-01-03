module Internationalization exposing (..)

import Dict
import Maybe exposing (withDefault, andThen)
import Translations.Types exposing (Language(..), Label)
import Translations.Norwegian as Nor
import Translations.English as Eng


textGetter : Language -> (Label -> Maybe String)
textGetter lang =
    case lang of
        Nor ->
            Nor.getText

        Eng ->
            Just << Eng.getText


getText : Language -> Label -> String
getText lang label =
    let
        local =
            textGetter lang

        english =
            Eng.getText
    in
        local label
            |> withDefault
                (english label)
