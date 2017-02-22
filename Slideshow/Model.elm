module Slideshow.Model exposing (Model, Slide, Msg(..))

{-|
@docs Model, Slide, Msg(Next, Previous)
-}

import Html exposing (Html)


{-|
-}
type alias Model =
    { slide : Slide
    , currentNo : Maybe Int
    }


{-|
-}
type alias Slide =
    { content : List (Html Msg) }


{-|
-}
type Msg
    = Next
    | Previous
