module Slideshow exposing (title, subtitle, heading, list)

import Html exposing (h1, text, div, ul, li)
import Html.Attributes exposing (style)


title content =
    div
        [ style
            [ ( "font-size", "100px" ) ]
        ]
        [ text content ]


subtitle content =
    div
        [ style
            [ ( "font-size", "70px" ) ]
        ]
        [ text content ]


heading content =
    h1
        [ style
            [ ( "font-size", "70px" ) ]
        ]
        [ text content ]


list items =
    ul
        []
        (List.map
            (\item -> li [] [ text item ])
            items
        )
