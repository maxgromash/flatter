package com.app.flatter.android.ui.news

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.databinding.FragmentNewsDetailsBinding
import com.bumptech.glide.Glide


class NewsDetailsFragment : Fragment() {

    private lateinit var binding: FragmentNewsDetailsBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentNewsDetailsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.toolBar.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        Glide.with(binding.root.context)
            .load("https://new-api.ingrad.ru/storage/news/4pUNde310wCPShNyZYXYs1gJISnaf29yueScaCgN.jpg")
            .centerCrop()
            .into(binding.image)
    }
}