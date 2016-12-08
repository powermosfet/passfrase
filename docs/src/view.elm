module View exposing (view)

import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (for, type_, value, checked)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)
import Message exposing (Msg(..))
import Model exposing (Model)
import Passphrase exposing (generatePassphrase)
import Html.CssHelpers as Hlp
import Styles.Styles as Styles
import Styles.Classes as Cls


{ id, class, classList } =
    Hlp.withNamespace ""


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Passfrase" ]
        , div [ class [ "form-group", "col-md-6" ] ]
            [ label [ for "inputNumberOfWords" ] [ text "Antall ord" ]
            , input
                [ type_ "range"
                , H.min "1"
                , H.max "10"
                , class [ "form-control" ]
                , id "inputNumberOfWords"
                , value (toString model.numberOfWords)
                , onInput ChangeNumberOfWords
                ]
                []
            ]
        , div [ class [ "form-group", "col-md-6" ] ]
            [ label [] [ text "Innstillinger" ]
            , checkbox "Sett inn mellomrom" ToggleSpaces model.insertSpaces
            , checkbox "Oppfyll tullete passordkrav" TogglePwRules model.satisfyPwRules
            , checkbox "Unngå æ/ø/å" ToggleAvoidNordicCharacters model.avoidNordicCharacters
            ]
        , div [ class [ Cls.PassphrasePanel ] ]
            [ div [ class [ "panel", "panel-default", "col-md-12" ] ]
                [ div [ class [ "panel-body" ] ]
                    [ h1 [ class [ Cls.PassphraseText ] ] [ text (generatePassphrase model) ]
                    ]
                ]
            ]
        ]


checkbox : String -> Msg -> Bool -> Html Msg
checkbox labelText msg value =
    div [ class [ "checkbox" ] ]
        [ label []
            [ input [ type_ "checkbox", onClick msg, checked value ] []
            , text labelText
            ]
        ]
