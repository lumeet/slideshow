module Slideshow exposing (model, view, update, subscriptions)

{-|
@docs model,update, subscriptions, view
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


{-| model
-}
model : Model
model =
    { currentNo = Nothing
    , slideCount = 0
    }


{-| update
-}
update : Array a -> a -> Msg -> Model -> ( a, Model, Cmd Msg )
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
        ( newSlide, newModel, cmds )


updateM msg model =
    case msg of
        Next ->
            ( model |> nextSlide, Cmd.none )

        Previous ->
            ( model |> previousSlide, Cmd.none )


nextSlide : Model -> Model
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


previousSlide : Model -> Model
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


updateSlideAt : Int -> Model -> Model
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
view : Page -> Model -> Html Msg
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


{-| init
-}
init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


{-| subscriptions
-}
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
