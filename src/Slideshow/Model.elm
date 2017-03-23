module Slideshow.Model exposing (Model, MetaSlide, Page)

{-|
@docs Model, MetaSlide, Page
-}

import Slideshow.Msgs exposing (Msg)
import Html exposing (Html)


{-|
-}
type alias Model slideType =
    { meta : MetaSlide
    , slide : slideType
    }


{-|
-}
type alias MetaSlide =
    { currentNo : Maybe Int
    , commentVisible : Bool
    }


{-|
-}
type alias Page =
    { content : List (Html Msg)
    , commentary : Maybe String
    }
