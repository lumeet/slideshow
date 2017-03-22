module Slideshow.View exposing (htmlView, appView)

{-|
@docs htmlView, appView
-}

import Slideshow.Model exposing (Model, Page)
import Slideshow.Msgs exposing (Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style, property)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Decode
import Json.Encode exposing (string)
import VirtualDom
import InlineHover exposing (hover)
import Array exposing (Array)


{-|
  htmlView
-}
htmlView : Page -> Array slide -> Maybe Int -> Html Msg
htmlView { content } slides currentNo =
    div
        [ style bodyStyle
        , onClick Next
        ]
        [ stylesheetLink "styles.css"
        , progressIndicator slides currentNo
        , div [] content
        , backLinkView
        ]


{-|
  appView
-}
appView : (appMsg -> msg) -> (Msg -> msg) -> Array slide -> Maybe Int -> Html appMsg -> Html msg
appView mapAppMsg mapSlideshowMsg slides currentNo view =
    div
        [ style bodyStyle
        ]
        [ stylesheetLink "styles.css"
        , Html.map mapSlideshowMsg (progressIndicator slides currentNo)
        , Html.map mapAppMsg view
        , Html.map mapSlideshowMsg backLinkView
        , Html.map mapSlideshowMsg forwardLinkView
        ]


stylesheetLink url =
    VirtualDom.node
        "link"
        [ property "rel" (string "stylesheet")
        , property "type" (string "text/css")
        , property "href" (string url)
        ]
        []


bodyStyle =
    [ ( "width", "100%" )
    , ( "height", "100%" )
    , ( "padding", "5% 10%" )
    , ( "box-sizing", "border-box" )
    , ( "font-size", "30px" )
    ]


linkStyle =
    [ ( "width", "100px" )
    , ( "height", "100%" )
    , ( "position", "fixed" )
    , ( "top", "0" )
    , ( "background", "transparent" )
    , ( "color", "white" )
    , ( "cursor", "pointer" )
    ]


backLinkStyle =
    ( "left", "0" ) :: linkStyle


forwardLinkStyle =
    ( "right", "0" ) :: linkStyle


progressIndicator slides currentNo =
    div
        [ style
            [ ( "left", "0" )
            , ( "top", "0" )
            , ( "height", "3px" )
            , ( "display", "block" )
            , ( "width", "100%" )
            , ( "position", "absolute" )
            , ( "background", "white" )
            ]
        ]
        [ div
            [ style
                [ ( "width", (toString <| progressPercentage slides currentNo) ++ "%" )
                , ( "height", "100%" )
                , ( "background", "blue" )
                ]
            ]
            []
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


progressPercentage slides currentNo =
    case currentNo of
        Just num ->
            case Array.length slides of
                0 ->
                    0

                _ ->
                    (num + 1) * 100 // Array.length slides

        Nothing ->
            0
