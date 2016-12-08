module Styles.Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (div, body, li)
import Styles.Colors as Color
import Styles.Classes as Class


css =
    stylesheet
        [ body
            [ backgroundColor Color.background
            ]
        , (.) Class.PassphrasePanel
            [ children
                [ div
                    [ backgroundColor Color.panel
                    , border zero
                    ]
                ]
            ]
        , (.) Class.PassphraseText
            [ color Color.background
            ]
        ]
