module Styles.Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Styles.Colors
import Styles.Classes


css =
    stylesheet
        [ body
            [ backgroundColor Styles.Colors.background
            ]
        , (.) Styles.Classes.PassphrasePanel
            [ backgroundColor Styles.Colors.panel
            , border zero
            ]
        , (.) Styles.Classes.PassphraseText
            [ color Styles.Colors.background
            ]
        ]
