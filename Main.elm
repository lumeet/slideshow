module Main exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Array
import Slides exposing (slides)


type alias Model =
    { slide : Slide }


type alias Slide =
    { content : List (Html Msg) }


type Msg
    = Next


emptySlide =
    { content = [] }


model =
    { slide =
        case Array.get 0 slides of
            Just slide ->
                slide

            Nothing ->
                emptySlide
    , currentNo = 1
    , slideCount = Array.length slides
    }


update msg model =
    case msg of
        Next ->
            model |> nextSlide


nextSlide model =
    case Array.get model.currentNo slides of
        Just slide ->
            { model | slide = slide, currentNo = model.currentNo + 1 }

        Nothing ->
            { model | slide = emptySlide, currentNo = 0 }


bodyStyle =
    [ ( "width", "100%" )
    , ( "height", "100%" )
    , ( "padding", "100px 200px" )
    , ( "box-sizing", "border-box" )
    , ( "font-size", "40px" )
    ]


view model =
    div
        [ style bodyStyle
        , onClick Next
        ]
        [ div [] model.slide.content ]


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
