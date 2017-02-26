module Slideshow.Update exposing (nextSlide, previousSlide)

import Array


nextSlide slides emptySlide model =
    let
        slideNo =
            case model.currentNo of
                Just num ->
                    num + 1

                _ ->
                    0
    in
        model |> updateSlideAt slideNo slides emptySlide


previousSlide slides emptySlide model =
    let
        slideNo =
            case model.currentNo of
                Just num ->
                    num - 1

                _ ->
                    (Array.length slides) - 1
    in
        model |> updateSlideAt slideNo slides emptySlide


updateSlideAt slideNo slides emptySlide model =
    let
        newSlide =
            case Array.get slideNo slides of
                Just slide ->
                    slide

                Nothing ->
                    emptySlide
    in
        { model | currentNo = Just slideNo, slide = newSlide }
