module Translations.English exposing (..)

import Translations.Types as T


getText : T.Label -> String
getText label =
    case label of
        T.CurrentLanguage ->
            "English"

        T.Title ->
            "Passfrase"

        T.PleaseWait ->
            "Please wait..."

        T.NumberOfWords ->
            "Number of words"

        T.Settings ->
            "Settings"

        T.InsertSpaces ->
            "Insert spaces"

        T.SatisfyPwRules ->
            "Satisfy silly password rules"

        T.AvoidNordicCharacters ->
            "Avoid nordic characters"
