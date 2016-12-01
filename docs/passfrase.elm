import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (for, type_, id, value, class, checked)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)

import Dictionary exposing (words)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = 
  { insertSpaces : Bool
  , satisfyPwRules : Bool
  , numberOfWords : Int
  , words: List String
  }
model : Model
model =
  { insertSpaces = False
  , satisfyPwRules = False
  , numberOfWords = 4
  , words = Dictionary.words
  }

-- UPDATE
type Msg = ToggleSpaces
         | TogglePwRules
         | ChangeNumberOfWords String

update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleSpaces ->
      { model | insertSpaces = not model.insertSpaces }
    TogglePwRules ->
      { model | satisfyPwRules = not model.satisfyPwRules }
    ChangeNumberOfWords strN ->
      let
        n = case (String.toInt strN) of
          Err _ -> 0
          Ok x -> x
      in
        { model | numberOfWords = n }

-- VIEW
view : Model -> Html Msg
view model = 
  div []
    [ h1 [] [ text "Passfrase" ]
    , div [ class "form-group col-md-3" ] 
      [ label [ for "inputNumberOfWords" ] [ text "Antall ord" ]
      , input 
        [ type_ "range"
        , H.min "1"
        , H.max "10"
        , class "form-control"
        , id "inputNumberOfWords"
        , value (toString model.numberOfWords) 
        , onInput ChangeNumberOfWords
        ] []
      ]
    , div [ class "form-group col-md-9" ] 
      [ label [] [ text "Innstillinger" ]
      , checkbox "Sett inn mellomrom" ToggleSpaces model.insertSpaces
      , checkbox "Oppfyll tullete passordkrav" TogglePwRules model.satisfyPwRules 
      ]
    , div [ class "panel panel-default passphrase-panel col-md-12" ]
        [ div [ class "panel-body" ]
          [ h1 [ class "passphrase-text" ] [ text ( generatePassphrase model ) ]
          ]
        ]
    ]

checkbox : String -> Msg -> Bool -> Html Msg
checkbox labelText msg value = 
  div [ class "checkbox" ]
    [ label [] 
      [ input [ type_ "checkbox", onClick msg, checked value ] []
      , text labelText
      ]
    ]

capitalize : String -> String
capitalize str =
  let
    c = String.left 1 str
    
    cs = String.dropLeft 1 str
  in
    String.toUpper c ++ cs

generatePassphraseList : Model -> List String
generatePassphraseList model =
  List.take model.numberOfWords model.words

generatePassphrase : Model -> String
generatePassphrase model =
  let
    passPhraseList =
      if model.satisfyPwRules
      then List.map capitalize (generatePassphraseList model)
      else (generatePassphraseList model)

    sep =
      if model.insertSpaces
      then " "
      else ""
  in
    String.join sep passPhraseList
                          
