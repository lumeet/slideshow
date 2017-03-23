module Slideshow.Update exposing (nextSlide, previousSlide, showCommentary)

import Array


nextSlide slides emptySlide model =
    let
        slideNo =
            case model.meta.currentNo of
                Just num ->
                    num + 1

                _ ->
                    0
    in
        model |> updateSlideAt slideNo slides emptySlide


previousSlide slides emptySlide model =
    let
        slideNo =
            case model.meta.currentNo of
                Just num ->
                    num - 1

                _ ->
                    (Array.length slides) - 1
    in
        model |> updateSlideAt slideNo slides emptySlide


updateSlideAt slideNo slides emptySlide model =
    let
        ( newSlide, newSlideNo ) =
            case Array.get slideNo slides of
                Just slide ->
                    ( slide, Just slideNo )

                Nothing ->
                    ( emptySlide, Nothing )

        meta =
            model.meta

        newMeta =
            { meta | currentNo = newSlideNo, commentVisible = False }
    in
        { model | meta = newMeta, slide = newSlide }


showCommentary model =
    let
        meta =
            model.meta

        newMeta =
            { meta | commentVisible = True }
    in
        { model | meta = newMeta }
