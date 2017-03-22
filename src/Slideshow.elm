module Slideshow exposing (view, update, subscriptions)

{-|
@docs update, subscriptions, view
-}

import Slideshow.Model exposing (Model, Page)
import Slideshow.Msgs exposing (Msg(..))
import Slideshow.Update exposing (nextSlide, previousSlide)
import Slideshow.View as View
import Html exposing (Html)
import Array exposing (Array)


{-| update
-}
update : Array slide -> slide -> Msg -> Model slide -> ( Model slide, Cmd msg )
update slides emptySlide msg model =
    case msg of
        Next ->
            ( model |> nextSlide slides emptySlide, Cmd.none )

        Previous ->
            ( model |> previousSlide slides emptySlide, Cmd.none )


{-| view
-}
view : Page -> Array slide -> Maybe Int -> Html Msg
view page slides currentNo =
    View.htmlView page slides currentNo


{-| subscriptions
-}
subscriptions : Model a -> Sub msg
subscriptions model =
    Sub.none
