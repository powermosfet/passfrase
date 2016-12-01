import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (for, type_, id, value, class)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = { words: [ String ]
                   }
model : Model
model =
  { words =
    [ "a-aksjer"
    , "a-ark"
    , "a-beta"
    , "a-beta-proteinet"
    , "a-brikke"
    , "a-dokumenter"
    , "a-familieliv"
    ]
  }

-- UPDATE
type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model = model

-- VIEW
view : Model -> Html Msg
view model = 
  div []
    [ h1 [] [ text "Passfrase" ]
    , div [ class "form-group col-md-3" ] 
      [ label [ for "inputNumberOfWords" ] [ text "Antall ord" ]
      , input [ type_ "range", class "form-control", id "inputNumberOfWords", value "4" ] []
      ]
    , div [ class "form-group col-md-9" ] 
      [ label [ for "inputNumberOfWords" ] [ text "Innstillinger" ]
      , div [ class "checkbox" ]
        [ label [] 
          [ input [ type_ "checkbox" ] []
          , text "Sett inn mellomrom" 
          ]
        ]
      , div [ class "checkbox" ]
        [ label [] 
          [ input [ type_ "checkbox" ] []
          , text "Oppfyll tullete passordkrav"
          ]
        ]
      ]
    , div [ class "panel panel-default passphrase-panel col-md-12" ]
        [ div [ class "panel-body" ]
          [ h1 [ class "passphrase-text" ] [ text "> Banan Klatretau Viskelær Jungel ¤4" ]
          ]
        ]
    ]
