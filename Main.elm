module Main exposing (..)

import Html exposing (Html, audio, div, kbd, program, span, text)
import Html.Attributes exposing (attribute, class, src)


type alias Key =
    { data : Int
    , keyName : String
    , sound : String
    }


init : List Key
init =
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


keyDiv : Key -> Html msg
keyDiv key =
    div
        [ class "key"
        , attribute "data-key" (toString key.data)
        ]
        [ kbd [] [ text key.keyName ]
        , span [ class "sound" ] [ text key.sound ]
        ]


audioEl : Key -> Html msg
audioEl key =
    audio
        [ attribute "data-key" (toString key.data)
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


main : Html msg
main =
    -- program
    --     { init = init
    --     , update = update
    --     , subscriptions = always Sub.none
    --     , view = view
    --     }
    view init
