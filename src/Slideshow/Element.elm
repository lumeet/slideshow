module Slideshow.Element exposing (title, subtitle, heading, list, quote, code)

{-| heading
    subtitle
    title
    list
    quote
@docs heading, title, subtitle, list, quote, code
-}

import Slideshow.Msgs exposing (Msg(..))
import Html exposing (Html, h1, text, div, ul, li, blockquote, pre, span)
import Html.Attributes exposing (style)


{-|
    title "x"
-}
title : String -> Html Msg
title content =
    div
        [ style
            [ ( "font-size", "250%" ) ]
        ]
        [ text content ]


{-|
    subtitle "x"
-}
subtitle : String -> Html Msg
subtitle content =
    div
        [ style
            [ ( "font-size", "180%" ) ]
        ]
        [ text content ]


{-|
    heading "x"
-}
heading : String -> Html Msg
heading content =
    h1
        [ style
            [ ( "font-size", "180%" ) ]
        ]
        [ text content ]


{-|
    list "x"
-}
list : List (List (Html Msg)) -> Html Msg
list items =
    ul
        []
        (List.map
            (\item -> li [] item)
            items
        )


{-|
    code "x"
-}
code : String -> Html Msg
code content =
    pre
        [ style
            [ ( "background", "#222" )
            , ( "color", "white" )
            , ( "padding", "20px" )
            ]
        ]
        [ text content ]


{-|
    title "x"
-}
quote : String -> Html Msg
quote str =
    blockquote []
        [ span
            [ style
                [ ( "font-size", "300%" )
                , ( "color", "gray" )
                ]
            ]
            [ text "\"" ]
        , text str
        ]
