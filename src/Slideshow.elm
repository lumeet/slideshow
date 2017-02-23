module Slideshow exposing (program)

{-| program
@docs program
-}

import Slideshow.Model exposing (Model, Slide, Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style, property)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Decode
import Json.Encode exposing (string)
import Array exposing (Array)
import VirtualDom
import InlineHover exposing (hover)


emptySlide =
    { content = [] }


model slides =
    { slide = emptySlide
    , currentNo = Nothing
    }


update slides msg model =
    case msg of
        Next ->
            model |> nextSlide slides

        Previous ->
            model |> previousSlide slides


nextSlide slides model =
    let
        slideNo =
            case model.currentNo of
                Just num ->
                    num + 1

                Nothing ->
                    0
    in
        model |> updateSlideAt slides slideNo


previousSlide slides model =
    let
        slideNo =
            case model.currentNo of
                Just num ->
                    num - 1

                Nothing ->
                    (Array.length slides) - 1
    in
        model |> updateSlideAt slides slideNo


updateSlideAt slides slideNo model =
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
    , ( "background", "white" )
    , ( "color", "white" )
    , ( "cursor", "pointer" )
    ]


stylesheetLink url =
    VirtualDom.node
        "link"
        [ property "rel" (string "stylesheet")
        , property "type" (string "text/css")
        , property "href" (string url)
        ]
        []


view model =
    div
        [ style bodyStyle
        , onClick Next
        ]
        [ stylesheetLink "styles.css"
        , div [] model.slide.content
        , hover [ ( "background", "rgba(0, 0, 0, 0.1)" ) ]
            div
            [ style backLinkStyle ]
            []
        ]


{-|
    program []
-}
program : Array Slide -> Program Never Model Msg
program slides =
    Html.beginnerProgram
        { model = model slides
        , view = view
        , update = update slides
        }
