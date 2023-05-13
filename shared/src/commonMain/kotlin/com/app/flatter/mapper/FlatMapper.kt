package com.app.flatter.mapper

import com.app.flatter.businessModels.FlatModel
import models.Flat

class FlatMapper : BaseMapper<Flat, FlatModel> {
    override fun invoke(state: Flat) = with(state) {
        FlatModel(
            id = id,
            price = price,
            rooms = rooms,
            number = number,
            area = area,
            floor = floor,
            trimming = trimming,
            finishing = finishing,
            images = images,
            isFavourite = isFavourite
        )
    }
}