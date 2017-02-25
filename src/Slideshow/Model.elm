module Slideshow.Model exposing (Model, Page, Slide(..), Msg(..))

{-|
@docs Model, Slide, Page, Msg(Next, Previous)
-}

import Html exposing (Html)


{-|
-}
type alias Model =
    { slideCount : Int
    , currentNo : Maybe Int
    }


{-|
-}
type alias Page =
    { content : List (Html Msg) }


{-|
-}
type alias App =
    { --    , update : Msg -> Model -> ( Model, Cmd Msg )
      --    , subscriptions : Model -> Sub Msg
      --    , view : Model -> Html Msg
    }


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



--| AppMsg String
