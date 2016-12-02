import Html exposing (Html, h1, label, button, div, text, input)
import Html.Attributes exposing (for, type_, id, value, class, checked)
import Html.Attributes as H exposing (min, max)
import Html.Events exposing (onClick, onInput)
import Random exposing (int, list)

import Dictionary exposing (words)

main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

-- MODEL
type alias Model = 
  { insertSpaces : Bool
  , satisfyPwRules : Bool
  , numberOfWords : Int
  , passphraseIndexes : List Int
  , words: List String
  }

init : (Model, Cmd Msg)
init =
  generateIndexes 
    { insertSpaces = True
    , satisfyPwRules = False
    , numberOfWords = 4
    , passphraseIndexes = [ 0, 1, 2, 3 ]
    , words = Dictionary.words
    }

-- UPDATE
type Msg = ToggleSpaces
         | TogglePwRules
         | ChangeNumberOfWords String
         | NewIndexes (List Int)

generateIndexes : Model -> (Model, Cmd Msg)
generateIndexes model =
  let
    maxIndex = List.length model.words - 1
  in 
    (model, Random.generate NewIndexes (list model.numberOfWords (int 0 maxIndex)))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleSpaces ->
      generateIndexes { model | insertSpaces = not model.insertSpaces }
    TogglePwRules ->
      generateIndexes { model | satisfyPwRules = not model.satisfyPwRules }
    ChangeNumberOfWords strN ->
      let
        n = case (String.toInt strN) of
          Err _ -> 0
          Ok x -> x
      in
        generateIndexes { model | numberOfWords = n }
    NewIndexes indexes ->
      ({ model | passphraseIndexes = indexes }, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model = 
  div []
    [ h1 [] [ text "Passfrase" ]
    , div [ class "form-group col-md-6" ] 
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
    , div [ class "form-group col-md-6" ] 
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

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

capitalize : String -> String
capitalize str =
  let
    c = String.left 1 str
    
    cs = String.dropLeft 1 str
  in
    String.toUpper c ++ cs

generatePassphraseList : Model -> List String
generatePassphraseList model =
  List.map (strGet model.words) model.passphraseIndexes

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
                          
get : List a -> Int  -> Maybe a
get xs n = List.head (List.drop n xs)
                          
strGet : List String -> Int  -> String
strGet cs n = Maybe.withDefault "" (get cs n)
