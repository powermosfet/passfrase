module Navbar exposing (navbar)

import Html exposing (Html, nav, h1, label, button, div, span, text, input, a, ul, li)
import Html.Attributes exposing (attribute, for, type_, value, checked, href)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)
import Message exposing (Msg(..))
import Model exposing (Model)
import Internationalization
import Dictionary exposing (Dictionary(..), getDescription)
import Translations.Types exposing (..)
import Html.CssHelpers as Hlp
import Styles.Styles as Styles
import Styles.Classes as Cls


{ id, class, classList } =
    Hlp.withNamespace ""


navbar : Model -> Html Msg
navbar model =
    let
        t =
            Internationalization.getText model.preferences.language
    in
        nav
            [ class [ "navbar", "navbar-default" ] ]
            [ div
                [ class [ "container-fluid" ] ]
                [ div
                    [ class [ "navbar-header" ] ]
                    [ button
                        [ type_ "button"
                        , class [ "navbar-toggle", "collapsed" ]
                        , attribute "data-toggle" "collapse"
                        , attribute "data-target" "#bs-navbar-collapsible"
                        , attribute "aria-expanded" "false"
                        ]
                        [ span [ class [ "sr-only" ] ] [ text "Toggle navigation" ]
                        , span [ class [ "icon-bar" ] ] []
                        , span [ class [ "icon-bar" ] ] []
                        , span [ class [ "icon-bar" ] ] []
                        ]
                    , a
                        [ class [ "navbar-brand" ]
                        , href "#"
                        ]
                        [ text (t Title) ]
                    ]
                , div
                    [ class [ "collapse", "navbar-collapse" ]
                    , id "bs-navbar-collapsible"
                    ]
                    [ ul
                        [ class [ "nav", "navbar-nav", "navbar-right" ] ]
                        [ li
                            [ class [ "dropdown" ] ]
                            [ a
                                [ href "#"
                                , class [ "dropdown-toggle" ]
                                , attribute "data-toggle" "dropdown"
                                , attribute "role" "button"
                                , attribute "aria-haspopup" "true"
                                , attribute "aria-expanded" "false"
                                ]
                                [ text (t CurrentLanguage)
                                , span [ class [ "caret" ] ] []
                                ]
                            , ul
                                [ class [ "dropdown-menu" ] ]
                                [ li []
                                    [ a [ href "#", onClick (ChangeLanguage "no") ] [ text "Norsk" ]
                                    , a [ href "#", onClick (ChangeLanguage "en") ] [ text "English" ]
                                    ]
                                ]
                            ]
                        , li
                            [ class [ "dropdown" ] ]
                            [ a
                                [ href "#"
                                , class [ "dropdown-toggle" ]
                                , attribute "data-toggle" "dropdown"
                                , attribute "role" "button"
                                , attribute "aria-haspopup" "true"
                                , attribute "aria-expanded" "false"
                                ]
                                [ text (getDescription model.preferences.dictionary)
                                , span [ class [ "caret" ] ] []
                                ]
                            , ul
                                [ class [ "dropdown-menu" ] ]
                                [ li []
                                    [ a [ href "#", onClick (ChangeDictionary Nrk) ] [ text <| getDescription Nrk ]
                                    , a [ href "#", onClick (ChangeDictionary Erotics) ] [ text <| getDescription Erotics ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
