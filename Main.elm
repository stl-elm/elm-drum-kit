module Main exposing (..)

import Html exposing (Html, audio, div, kbd, program, span, text)
import Html.Attributes exposing (attribute, class, src)


-- MODEL


type alias Key =
    { charCode : Int
    , keyName : String
    , sound : String
    }


initialModel : List Key
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



-- VIEW


keyDiv : Key -> Html msg
keyDiv key =
    div
        [ class "key"
        , attribute "data-key" (toString key.charCode)
        ]
        [ kbd [] [ text key.keyName ]
        , span [ class "sound" ] [ text key.sound ]
        ]


audioEl : Key -> Html msg
audioEl key =
    audio
        [ attribute "data-key" (toString key.charCode)
        , src ("sounds/" ++ key.sound ++ ".wav")
        ]
        []


view : List Key -> Html msg
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


update : List Key -> msg -> ( List Key, Cmd msg )
update keys msg =
    case msg of
        _ ->
            keys ! []



-- MAIN


main : Program Never (List Key) (List Key)
main =
    program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
