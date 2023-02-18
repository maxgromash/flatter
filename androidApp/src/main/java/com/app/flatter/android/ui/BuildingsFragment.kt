package com.app.flatter.android.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.app.flatter.android.databinding.FragmentBuildingsBinding

internal class BuildingsFragment : Fragment() {

    private lateinit var binding: FragmentBuildingsBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentBuildingsBinding.inflate(inflater)
        return binding.root
    }
}