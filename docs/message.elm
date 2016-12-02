module Message exposing (Msg(..))

import Http

type Msg = ToggleSpaces
         | TogglePwRules
         | ChangeNumberOfWords String
         | NewIndexes (List Int)
         | NewWords (Result Http.Error (List String))
         | NewPassphrase

