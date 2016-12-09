module Translations.English exposing (..)

import Translations.Types as T


getText : T.Label -> Maybe String
getText label =
    case label of
        T.Title ->
            Just "Passfrase"

        T.PleaseWait ->
            Just "Please wait..."

        T.NumberOfWords ->
            Just "Number of words"

        T.Settings ->
            Just "Settings"

        T.InsertSpaces ->
            Just "Insert spaces"

        T.SatisfyPwRules ->
            Just "Satisfy silly password rules"

        T.AvoidNordicCharacters ->
            Just "Avoid nordic characters"
