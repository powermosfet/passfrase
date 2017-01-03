module Message exposing (Msg(..))

import Http
import Dictionary exposing (Dictionary)
import Translations.Types exposing (Language)


type Msg
    = ToggleSpaces
    | TogglePwRules
    | ToggleAvoidNordicCharacters
    | ChangeNumberOfWords String
    | NewIndexes (List Int)
    | NewWords (Result Http.Error (List String))
    | NewPassphrase
    | ChangeLanguage Language
    | ChangeDictionary Dictionary
