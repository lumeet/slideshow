module Slideshow exposing (view, update, subscriptions)

{-|
@docs update, subscriptions, view
-}

import Slideshow.Model exposing (Model, MetaSlide, Page)
import Slideshow.Msgs exposing (Msg(..))
import Slideshow.Update exposing (nextSlide, previousSlide, showCommentary)
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

        ShowCommentary ->
            ( model |> showCommentary, Cmd.none )

        Previous ->
            ( model |> previousSlide slides emptySlide, Cmd.none )


{-| view
-}
view : Page -> Array slide -> MetaSlide -> Html Msg
view page slides meta =
    View.htmlView page slides meta


{-| subscriptions
-}
subscriptions : Model a -> Sub msg
subscriptions model =
    Sub.none
