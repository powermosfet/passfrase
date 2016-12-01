import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (for, type_, id, value, class, checked)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = 
  { insertSpaces : Bool
  , satisfyPwRules : Bool
  , words: List String
  }
model : Model
model =
  { insertSpaces = False
  , satisfyPwRules = False
  , words =
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
type Msg = ToggleSpaces
         | TogglePwRules

update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleSpaces ->
      { model | insertSpaces = not model.insertSpaces }
    TogglePwRules ->
      { model | satisfyPwRules = not model.satisfyPwRules }

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
          [ input [ type_ "checkbox", onClick ToggleSpaces, checked model.insertSpaces ] []
          , text "Sett inn mellomrom" 
          ]
        ]
      , div [ class "checkbox" ]
        [ label [] 
          [ input [ type_ "checkbox", onClick TogglePwRules, checked model.satisfyPwRules ] []
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
