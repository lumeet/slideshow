module Slideshow.Model exposing (Model, Page)

{-|
@docs Model, Page
-}

import Slideshow.Msgs exposing (Msg)
import Html exposing (Html)


{-|
-}
type alias Model slideType =
    { currentNo : Maybe Int
    , slide : slideType
    }


{-|
-}
type alias Page =
    { content : List (Html Msg) }
