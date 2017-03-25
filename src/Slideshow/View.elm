module Slideshow.View exposing (htmlView, appView)

{-|
@docs htmlView, appView
-}

import Slideshow.Model exposing (Model, MetaSlide, Page)
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
htmlView : Page -> Array slide -> MetaSlide -> Html Msg
htmlView { content, commentary } slides meta =
    div
        [ style bodyStyle
        , onClick (forwardMsg commentary meta)
        ]
        [ stylesheetLink "styles.css"
        , progressIndicator slides meta.currentNo
        , div [] content
        , if meta.commentVisible then
            comment commentary
          else
            (text "")
        , backLinkView
        ]


{-|
  appView
-}
appView : (appMsg -> msg) -> (Msg -> msg) -> Array slide -> MetaSlide -> Html appMsg -> Html msg
appView mapAppMsg mapSlideshowMsg slides meta view =
    div
        [ style bodyStyle
        ]
        [ stylesheetLink "styles.css"
        , Html.map mapSlideshowMsg (progressIndicator slides meta.currentNo)
        , Html.map mapAppMsg view
        , Html.map mapSlideshowMsg backLinkView
        , Html.map mapSlideshowMsg (forwardLinkView Nothing meta)
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


forwardLinkView comment meta =
    linkView (forwardMsg comment meta) forwardLinkStyle


linkView action styles =
    hover [ ( "background", "rgba(0, 0, 0, 0.1)" ) ]
        div
        [ style styles
        , onWithOptions "click"
            { preventDefault = True, stopPropagation = True }
            (Decode.succeed action)
        ]
        []


comment commentary =
    case commentary of
        Just label ->
            div
                [ style
                    [ ( "position", "absolute" )
                    , ( "top", "20%" )
                    , ( "right", "10px" )
                    , ( "display", "inline-block" )
                    , ( "border-radius", "30px" )
                    , ( "padding", "20px" )
                    , ( "background", "white" )
                    , ( "color", "black" )
                    , ( "border", "solid 4px black" )
                    ]
                ]
                [ text label
                , div
                    [ style
                        [ ( "position", "absolute" )
                        , ( "width", "0" )
                        , ( "height", "0" )
                        , ( "bottom", "-50px" )
                        , ( "right", "20px" )
                        , ( "border", "solid 25px" )
                        , ( "border-color", "black black transparent transparent" )
                        ]
                    ]
                    []
                , div
                    [ style
                        [ ( "position", "absolute" )
                        , ( "width", "0" )
                        , ( "height", "0" )
                        , ( "bottom", "-45px" )
                        , ( "right", "22px" )
                        , ( "border", "solid 23px" )
                        , ( "border-color", "white white transparent transparent" )
                        ]
                    ]
                    []
                ]

        Nothing ->
            text ""


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


forwardMsg comment { commentVisible } =
    case ( comment, commentVisible ) of
        ( Just _, False ) ->
            ShowCommentary

        _ ->
            Next
