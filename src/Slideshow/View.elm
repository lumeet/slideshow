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


{-|
  htmlView
-}
htmlView : Page -> Html Msg
htmlView { content } =
    div
        [ style bodyStyle
        , onClick Next
        ]
        [ stylesheetLink "styles.css"
        , div [] content
        , backLinkView
        ]


{-|
  appView
-}
appView : (appMsg -> msg) -> (Msg -> msg) -> Html appMsg -> Html msg
appView mapAppMsg mapSlideshowMsg view =
    div
        [ style bodyStyle
        ]
        [ stylesheetLink "styles.css"
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
