module View exposing (view)

import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (attribute, for, type_, value, checked)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)
import Message exposing (Msg(..))
import Model exposing (Model)
import Internationalization
import Translations.Types exposing (..)
import Passphrase exposing (generatePassphrase)
import Html.CssHelpers as Hlp
import Styles.Styles as Styles
import Styles.Classes as Cls
import Navbar


{ id, class, classList } =
    Hlp.withNamespace ""


view : Model -> Html Msg
view model =
    let
        prf =
            model.preferences

        t =
            Internationalization.getText prf.language
    in
        div []
            [ Navbar.navbar model
            , div [ class [ "form-group", "col-md-6" ] ]
                [ label [ for "inputNumberOfWords" ] [ text (t NumberOfWords) ]
                , input
                    [ type_ "range"
                    , H.min "1"
                    , H.max "10"
                    , class [ "form-control" ]
                    , id "inputNumberOfWords"
                    , value (toString prf.numberOfWords)
                    , onInput ChangeNumberOfWords
                    ]
                    []
                ]
            , div [ class [ "form-group", "col-md-6" ] ]
                [ label [] [ text (t Settings) ]
                , checkbox (t InsertSpaces) ToggleSpaces prf.insertSpaces
                , checkbox (t SatisfyPwRules) TogglePwRules prf.satisfyPwRules
                , checkbox (t AvoidNordicCharacters) ToggleAvoidNordicCharacters prf.avoidNordicCharacters
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
