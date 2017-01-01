module Translations.Norwegian exposing (..)

import Translations.Types as T


getText : T.Label -> Maybe String
getText label =
    case label of
        T.CurrentLanguage ->
            Just "Norsk"

        T.Title ->
            Just "Passfrase"

        T.PleaseWait ->
            Just "Vennligst vent..."

        T.NumberOfWords ->
            Just "Antall ord"

        T.Settings ->
            Just "Innstillinger"

        T.InsertSpaces ->
            Just "Sett inn mellomrom"

        T.SatisfyPwRules ->
            Just "Oppfyll tullete passordkrav"

        T.AvoidNordicCharacters ->
            Just "Unngå æ/ø/å"
