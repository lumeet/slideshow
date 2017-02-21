module Slides exposing (slides)

import Slideshow exposing (title, subtitle, heading, list)
import Array


slides =
    Array.fromList <|
        List.map
            (\html -> { content = html })
            slideData


slideData =
    [ [ title "Another Journey in the Elmland"
      , subtitle "Boom boom"
      ]
    , [ heading "What's Elm?"
      , list
            [ "A bit like ES6 + React + Redux + Flowtype" ]
      ]
    ]
