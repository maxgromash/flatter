package com.app.flatter.android.ui.news

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.NavOptions
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentNewsBinding
import com.app.flatter.android.ui.news.adapter.NewsAdapter
import com.app.flatter.android.ui.news.adapter.NewsDecoration
import com.app.flatter.android.data.NewsVO

class NewsFragment : Fragment() {

    private lateinit var binding: FragmentNewsBinding
    private val adapterNews = NewsAdapter { newsVO ->
        findNavController().navigate(
            R.id.action_newsFragment_to_newsDetailsFragment,

        )
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentNewsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        with(binding.newsListRV) {
            adapter = adapterNews
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            addItemDecoration(NewsDecoration())
        }

        binding.toolBarTB.title = "Новости"

        adapterNews.setItems(
            listOf(
                NewsVO(
                    "20 марта 2023 г.",
                    "INGRAD обеспечил высокую строительную готовность ЖК «Миловидное»",
                    "https://new-api.ingrad.ru/storage/news/4pUNde310wCPShNyZYXYs1gJISnaf29yueScaCgN.jpg"
                ),
                NewsVO(
                    "16 марта 2023 г.",
                    "Группа «Самолет» и СберКорус впервые в России внедрили EDI-систему для обмена данными с поставщиками и подрядчиками",
                    "https://new-api.ingrad.ru/storage/news/R22z055VSKdIvasIDRDtX3do1p8dJtLKwwt2bHAq.jpg"
                ),
                NewsVO(
                    "13 февр. 2023 г.",
                    "Итальянский бренд керамики высоко оценил фасады ЖК RiverSky",
                    "https://new-api.ingrad.ru/storage/news/GplWjG79OfTlL931LP5m5BqPAqPPdhvAXX3Aae2q.jpg"
                ),
                NewsVO(
                    "26 янв. 2023 г.",
                    "INGRAD приступил к заселению корпуса №22 ЖК «Новое Пушкино»",
                    "https://new-api.ingrad.ru/storage/news/JC3PPyUAlmWaZh9AK6E5ZzchGh3Kjw9JH2NBHgAn.jpg"
                )
            )
        )
    }
}