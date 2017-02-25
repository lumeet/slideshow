module Slideshow.Element exposing (title, subtitle, heading, list, quote)

{-| heading
    subtitle
    title
    list
    quote
@docs heading, title, subtitle, list, quote
-}

import Slideshow.Model exposing (Msg(..))
import Html exposing (Html, h1, text, div, ul, li, blockquote)
import Html.Attributes exposing (style)


{-|
    title "x"
-}
title : String -> Html Msg
title content =
    div
        [ style
            [ ( "font-size", "100px" ) ]
        ]
        [ text content ]


{-|
    subtitle "x"
-}
subtitle : String -> Html Msg
subtitle content =
    div
        [ style
            [ ( "font-size", "70px" ) ]
        ]
        [ text content ]


{-|
    heading "x"
-}
heading : String -> Html Msg
heading content =
    h1
        [ style
            [ ( "font-size", "70px" ) ]
        ]
        [ text content ]


{-|
    list "x"
-}
list : List String -> Html Msg
list items =
    ul
        []
        (List.map
            (\item -> li [] [ text item ])
            items
        )


{-|
    title "x"
-}
quote : String -> Html Msg
quote str =
    blockquote [] [ text str ]
