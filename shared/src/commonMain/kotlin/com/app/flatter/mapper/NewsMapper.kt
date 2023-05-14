package com.app.flatter.mapper

import com.app.flatter.businessModels.NewsModel
import models.News

class NewsMapper: BaseMapper<List<News>, List<NewsModel>> {
    override fun invoke(state: List<News>): List<NewsModel> {
        return state.map { it.toModel() }
    }

    private fun News.toModel(): NewsModel {
        return NewsModel(
            id = this.id,
            title = this.title,
            description = this.description,
            publicationDate = this.date,
            imageURL = this.images.first()
        )
    }
}