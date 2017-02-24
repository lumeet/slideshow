module Slideshow exposing (program)

{-| program
@docs program
-}

import Slideshow.Model exposing (Model, Slide(..), Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style, property)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Decode
import Json.Encode exposing (string)
import Array exposing (Array)
import VirtualDom
import InlineHover exposing (hover)


emptySlide =
    PageSlide { content = [] }


model slides =
    { slide = emptySlide
    , currentNo = Nothing
    }


update : Array Slide -> Msg -> Model -> ( Model, Cmd Msg )
update slides msg model =
    case msg of
        Next ->
            ( model |> nextSlide slides, Cmd.none )

        Previous ->
            ( model |> previousSlide slides, Cmd.none )

        AppMsg appMsg ->
            model |> processAppMsg appMsg


nextSlide : Array Slide -> Model -> Model
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


updateSlideAt : Array Slide -> Int -> Model -> Model
updateSlideAt slides slideNo model =
    case Array.get slideNo slides of
        Just slide ->
            { model | slide = slide, currentNo = Just slideNo }

        Nothing ->
            { model | slide = emptySlide, currentNo = Nothing }


processAppMsg msg model =
    ( model, Cmd.none )


bodyStyle =
    [ ( "width", "100%" )
    , ( "height", "100%" )
    , ( "padding", "100px 200px" )
    , ( "box-sizing", "border-box" )
    , ( "font-size", "40px" )
    ]


linkStyle =
    [ ( "width", "100px" )
    , ( "height", "100%" )
    , ( "position", "fixed" )
    , ( "top", "0" )
    , ( "background", "white" )
    , ( "color", "white" )
    , ( "cursor", "pointer" )
    ]


backLinkStyle =
    ( "left", "0" ) :: linkStyle


forwardLinkStyle =
    ( "right", "0" ) :: linkStyle


stylesheetLink url =
    VirtualDom.node
        "link"
        [ property "rel" (string "stylesheet")
        , property "type" (string "text/css")
        , property "href" (string url)
        ]
        []


view model =
    case model.slide of
        PageSlide page ->
            pageView page

        AppSlide page ->
            appView page


pageView { content } =
    div
        [ style bodyStyle
        , onClick Next
        ]
        [ stylesheetLink "styles.css"
        , div [] content
        , backLinkView
        ]


appView app =
    div
        [ style bodyStyle
        ]
        [ stylesheetLink "styles.css"
        , div [] [ text "Empty App" ]
        , backLinkView
        , forwardLinkView
        ]


backLinkView =
    linkView Previous backLinkStyle


forwardLinkView =
    linkView Next forwardLinkStyle


linkView action styles =
    hover [ ( "background", "rgba(0, 0, 0, 0.1)" ) ]
        div
        [ style styles
        , onWithOptions "click"
            { preventDefault = True, stopPropagation = True }
            (Decode.succeed action)
        ]
        []


init : Array Slide -> ( Model, Cmd Msg )
init slides =
    ( model slides, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


{-|
    program []

-}
program : Array Slide -> Program Never Model Msg
program slides =
    Html.program
        { init = init slides
        , view = view
        , update = update slides
        , subscriptions = subscriptions
        }
