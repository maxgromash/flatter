package com.app.flatter.android.ui.news

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.databinding.FragmentNewsDetailsBinding
import com.app.flatter.android.viewModel.NewsViewModel
import com.bumptech.glide.Glide

class NewsDetailsFragment : Fragment() {

    private lateinit var viewModel: NewsViewModel
    private lateinit var binding: FragmentNewsDetailsBinding

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentNewsDetailsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(requireActivity())[NewsViewModel::class.java]

        binding.toolBar.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        val id = arguments?.getInt("id")

        val news = viewModel.getNewsById(id!!)

        news?.let {
            Glide.with(binding.root.context)
                .load(news.imageURL)
                .centerCrop()
                .into(binding.image)

            binding.title.text = news.title
            binding.contentMTV.text = news.description
        }
    }
}