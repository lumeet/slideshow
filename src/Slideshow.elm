module Slideshow exposing (view, update, subscriptions)

{-|
@docs update, subscriptions, view
-}

import Slideshow.Model exposing (Model, Page, Slide(..), Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style, property)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Decode
import Json.Encode exposing (string)
import Array exposing (Array)
import VirtualDom
import InlineHover exposing (hover)


{-| update
-}
update : Array a -> a -> Msg -> Model a -> ( Model a, Cmd Msg )
update slides emptySlide msg model =
    let
        ( newModel, cmds ) =
            updateM msg model

        newSlide =
            case newModel.currentNo of
                Just slideNo ->
                    case Array.get slideNo slides of
                        Just slide ->
                            slide

                        Nothing ->
                            emptySlide

                Nothing ->
                    emptySlide
    in
        ( { newModel | slide = newSlide }, cmds )


updateM msg model =
    case msg of
        Next ->
            ( model |> nextSlide, Cmd.none )

        Previous ->
            ( model |> previousSlide, Cmd.none )


nextSlide : Model a -> Model a
nextSlide model =
    let
        { currentNo, slideCount } =
            model

        slideNo =
            case currentNo of
                Just num ->
                    if num + 1 < slideCount then
                        num + 1
                    else
                        0

                Nothing ->
                    0
    in
        model |> updateSlideAt slideNo


previousSlide : Model a -> Model a
previousSlide model =
    let
        { currentNo, slideCount } =
            model

        slideNo =
            case currentNo of
                Just num ->
                    if num - 1 < 0 then
                        slideCount - 1
                    else
                        num - 1

                Nothing ->
                    0
    in
        model |> updateSlideAt slideNo


updateSlideAt : Int -> Model a -> Model a
updateSlideAt slideNo model =
    { model | currentNo = Just slideNo }


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


{-| view
-}
view : Page -> Model a -> Html Msg
view page model =
    pageView page


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


{-| subscriptions
-}
subscriptions : Model a -> Sub Msg
subscriptions model =
    Sub.none
