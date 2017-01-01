module Message exposing (Msg(..))

import Http
import Dictionary exposing (Dictionary)


type Msg
    = ToggleSpaces
    | TogglePwRules
    | ToggleAvoidNordicCharacters
    | ChangeNumberOfWords String
    | NewIndexes (List Int)
    | NewWords (Result Http.Error (List String))
    | NewPassphrase
    | ChangeLanguage String
    | ChangeDictionary Dictionary
