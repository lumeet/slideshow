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
update : Array slide -> slide -> Msg -> Model slide -> ( Model slide, Cmd Msg )
update slides emptySlide msg model =
    case msg of
        Next ->
            ( model |> nextSlide slides emptySlide, Cmd.none )

        Previous ->
            ( model |> previousSlide slides emptySlide, Cmd.none )


{-| view
-}
view : Page -> Html Msg
view page =
    View.htmlView page


appView : Model slide -> Html Msg
appView model =
    View.appView model


{-| subscriptions
-}
subscriptions : Model a -> Sub Msg
subscriptions model =
    Sub.none
