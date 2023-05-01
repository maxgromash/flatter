package com.app.flatter.android.ui.flats.flatDetails

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.LinearSnapHelper
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentFlatDetailsBinding
import com.app.flatter.android.ui.flats.flatDetails.adapter.FlatDetailsAdapter
import com.app.flatter.android.viewModel.MainViewModel


class FlatDetailsFragment : Fragment() {

    private lateinit var viewModel: MainViewModel
    private lateinit var binding: FragmentFlatDetailsBinding
    private val snapHelper = LinearSnapHelper()
    private val adapterDetails = FlatDetailsAdapter()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        viewModel = ViewModelProvider(requireActivity())[MainViewModel::class.java]
        binding = FragmentFlatDetailsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val model = ViewModelProvider(requireActivity())[MainViewModel::class.java]
        val id = arguments?.getInt("id")
        val item = model.getFlatDetailsById(id!!)

        binding.toolbar.subtitle = "Назад"
        binding.toolbar.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        binding.listRV.apply {
            adapter = adapterDetails
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
            snapHelper.attachToRecyclerView(this)
            binding.indicator.attachToRecyclerView(this)
        }


        item?.let {
            binding.mortgage.bind(item.price)
            adapterDetails.setItems(it.layout)
            binding.roomMTV.text = it.roomNumber.toString()
            binding.floorMTV.text = it.floor.toString()
            binding.squareMTV.text = it.square.toString()
            binding.price.text = it.priceString
            binding.rooms.text = it.roomsCount.toString()
            binding.finishing.text = it.typeOfFinish
            binding.surrender.text = it.surrender

            binding.starAPIV.setOnClickListener {
                viewModel.setStar(item.id)
            }

            if (item.isStarred)
                binding.starAPIV.setImageResource(R.drawable.ic_baseline_star_24)
            else
                binding.starAPIV.setImageResource(R.drawable.ic_baseline_star_border_24)
        }
    }

    private fun setStarState() {

    }
}