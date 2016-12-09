module Translations.Norwegian exposing (..)

import Translations.Types as T


getText : T.Label -> Maybe String
getText label =
    case label of
        PleaseWait ->
            Just "Vennligst vent..."

        NumberOfWords ->
            Just "Antall ord"

        InsertSpaces ->
            Just "Sett inn mellomrom"

        SatisfyPwRules ->
            Just "Oppfyll tullete passordkrav"

        AvoidNordicCharacters ->
            Just "Unngå æ/ø/å"

        _ ->
            Nothing
          , Dict.fromList
                [ ( PleaseWait, "Please wait..." )
                , ( NumberOfWords, "Number of words" )
                , ( InsertSpaces, "Insert spaces" )
                , ( SatisfyPwRules, "Satisfy silly password rules" )
                , ( AvoidNordicCharacters, "Avoid nordic characters" )
                ]
