module Passphrase exposing (..)

import Regex exposing (HowMany(All), regex, replace)
import Model exposing (Model)
import Internationalization
import Translations.Types exposing (Label(PleaseWait))


generatePassphraseList : Model -> List String
generatePassphraseList model =
    List.map (strGet model.words) model.passphraseIndexes


generatePassphrase : Model -> String
generatePassphrase model =
    let
        prf =
            model.preferences

        maybeRemoveNordicCharacters =
            if prf.avoidNordicCharacters then
                removeNordicCharacters
            else
                identity

        passPhraseList =
            if prf.satisfyPwRules then
                List.map capitalize (generatePassphraseList model ++ [ "%5" ])
            else
                (generatePassphraseList model)

        sep =
            if prf.insertSpaces then
                " "
            else
                ""
    in
        if passPhraseList == [] then
            Internationalization.getText model.preferences.language PleaseWait
        else
            String.join sep passPhraseList
                |> maybeRemoveNordicCharacters


removeNordicCharacters : String -> String
removeNordicCharacters =
    let
        rep pattern replacement =
            replace All (regex pattern) (\_ -> replacement)
    in
        rep "æ" "ae" << rep "ø" "oe" << rep "å" "aa"


capitalize : String -> String
capitalize str =
    let
        c =
            String.left 1 str

        cs =
            String.dropLeft 1 str
    in
        String.toUpper c ++ cs


get : List a -> Int -> Maybe a
get xs n =
    List.head (List.drop n xs)


strGet : List String -> Int -> String
strGet cs n =
    Maybe.withDefault "" (get cs n)
