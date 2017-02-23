module Slideshow.Element exposing (title, subtitle, heading, list)

{-| heading
    subtitle
    title
    list
@docs heading, title, subtitle, list
-}

import Slideshow.Model exposing (Msg(..))
import Html exposing (Html, h1, text, div, ul, li)
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
