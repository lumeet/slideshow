module Slideshow.Model exposing (Model, Page, Slide(..), Msg(..))

{-|
@docs Model, Slide, Page, Msg(Next, Previous)
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
type alias Page =
    { content : List (Html Msg) }


{-|
-}
type alias App =
    { msg : Msg }


{-|
-}
type Slide
    = PageSlide Page
    | AppSlide App


{-|
-}
type Msg
    = Next
    | Previous
    | AppMsg String
