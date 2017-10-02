module Main exposing (..)

import Html exposing (Html, audio, div, kbd, program, span, sub, text)
import Html.Attributes exposing (attribute, class, src)
import Keyboard


-- MODEL


type alias Key =
    { charCode : Int
    , keyName : String
    , sound : String
    }


type alias Model =
    List Key


initialModel : Model
initialModel =
    [ Key 65 "A" "clap"
    , Key 83 "S" "hihat"
    , Key 68 "D" "kick"
    , Key 70 "F" "openhat"
    , Key 71 "G" "boom"
    , Key 72 "H" "ride"
    , Key 74 "J" "snare"
    , Key 75 "K" "tom"
    , Key 76 "L" "tink"
    ]



-- MESSAGES


type Msg
    = KeyMsg Keyboard.KeyCode



-- VIEW


keyDiv : Key -> Html Msg
keyDiv key =
    div
        [ class "key"
        , attribute "data-key" (toString key.charCode)
        ]
        [ kbd [] [ text key.keyName ]
        , span [ class "sound" ] [ text key.sound ]
        ]


audioEl : Key -> Html Msg
audioEl key =
    audio
        [ attribute "data-key" (toString key.charCode)
        , src ("sounds/" ++ key.sound ++ ".wav")
        ]
        []


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ div
            [ class "keys" ]
            (List.map keyDiv model)
        , div
            [ class "audio-files" ]
            (List.map audioEl model)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        _ ->
            model ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Keyboard.downs KeyMsg ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
