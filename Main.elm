module Main exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Decode
import Array
import Slides exposing (slides)


type alias Model =
    { slide : Slide }


type alias Slide =
    { content : List (Html Msg) }


type Msg
    = Next
    | Previous


emptySlide =
    { content = [] }


model =
    let
        initial =
            updateSlideAt 0
    in
        { initial | slideCount = Array.length slides }


update msg model =
    case msg of
        Next ->
            model |> nextSlide

        Previous ->
            model |> previousSlide


nextSlide model =
    let
        slideNo =
            case model.currentNo of
                Just num ->
                    num + 1

                Nothing ->
                    0
    in
        updateSlideAt slideNo


previousSlide model =
    let
        slideNo =
            case model.currentNo of
                Just num ->
                    num - 1

                Nothing ->
                    (Array.length slides) - 1
    in
        updateSlideAt slideNo


updateSlideAt slideNo =
    case Array.get slideNo slides of
        Just slide ->
            { model | slide = slide, currentNo = Just slideNo }

        Nothing ->
            { model | slide = emptySlide, currentNo = Nothing }


bodyStyle =
    [ ( "width", "100%" )
    , ( "height", "100%" )
    , ( "padding", "100px 200px" )
    , ( "box-sizing", "border-box" )
    , ( "font-size", "40px" )
    ]


backLinkStyle =
    [ ( "width", "100px" )
    , ( "height", "100%" )
    , ( "position", "fixed" )
    , ( "top", "0" )
    , ( "left", "0" )
    , ( "background", "black" )
    , ( "color", "white" )
    ]


view model =
    div
        [ style bodyStyle
        , onClick Next
        ]
        [ div [] model.slide.content
        , div
            [ style backLinkStyle
            , onWithOptions "click"
                { preventDefault = True, stopPropagation = True }
                (Decode.succeed Previous)
            ]
            [ text "<-" ]
        ]


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
