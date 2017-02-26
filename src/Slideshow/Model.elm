module Slideshow.Model exposing (Model, Page, Msg(..))

{-|
@docs Model, Page, Msg(Next, Previous)
-}

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


{-|
-}
type alias App =
    { --    , update : Msg -> Model -> ( Model, Cmd Msg )
      --    , subscriptions : Model -> Sub Msg
      --    , view : Model -> Html Msg
    }


{-|
-}
type Msg
    = Next
    | Previous



--| AppMsg String
