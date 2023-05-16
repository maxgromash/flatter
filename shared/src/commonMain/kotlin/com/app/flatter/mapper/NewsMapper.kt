package com.app.flatter.mapper

import com.app.flatter.businessModels.NewsModel
import models.News

class NewsMapper : BaseMapper<List<News>, List<NewsModel>> {
    override fun invoke(state: List<News>): List<NewsModel> {
        return state.map(::mapNewsModel)
    }

    private fun mapNewsModel(dto: News) = with(dto) {
        NewsModel(
            id = id,
            title = title,
            description = description,
            publicationDate = date,
            imageURL = images.first()
        )
    }
}