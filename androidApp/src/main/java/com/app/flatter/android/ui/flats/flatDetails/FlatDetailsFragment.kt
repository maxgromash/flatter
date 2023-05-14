package com.app.flatter.android.ui.flats.flatDetails

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.LinearSnapHelper
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentFlatDetailsBinding
import com.app.flatter.android.ui.flats.flatDetails.adapter.FlatDetailsAdapter
import com.app.flatter.android.util.formatBySpace
import com.app.flatter.android.viewModel.FlatsViewModel

class FlatDetailsFragment : Fragment() {

    private lateinit var viewModel: FlatsViewModel
    private lateinit var binding: FragmentFlatDetailsBinding
    private val snapHelper = LinearSnapHelper()
    private val adapterDetails = FlatDetailsAdapter()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        viewModel = ViewModelProvider(requireActivity())[FlatsViewModel::class.java]
        binding = FragmentFlatDetailsBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val model = ViewModelProvider(requireActivity())[FlatsViewModel::class.java]
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
            binding.mortgage.bind(item.price.toInt())
            adapterDetails.setItems(it.images)
            binding.roomMTV.text = it.number.toString()
            binding.floorMTV.text = it.floor.toString()
            binding.squareMTV.text = it.area.toString()
            binding.price.text = "${it.price.formatBySpace()} Р"
            binding.rooms.text = it.rooms.toString()
            binding.finishing.text = it.trimming
            binding.surrender.text = it.finishing

            binding.starAPIV.setOnClickListener {
                viewModel.setStar(item.id)
            }

            if (item.isFavourite)
                binding.starAPIV.setImageResource(R.drawable.ic_baseline_star_24)
            else
                binding.starAPIV.setImageResource(R.drawable.ic_baseline_star_border_24)
        }

        binding.bookFlat.setOnClickListener {
            if (ContextCompat.checkSelfPermission(
                    requireContext(),
                    android.Manifest.permission.CALL_PHONE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                ActivityCompat.requestPermissions(
                    requireActivity(),
                    arrayOf(android.Manifest.permission.CALL_PHONE),
                    123
                )
            } else {
                val intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:" + "89227045875"))
                startActivity(intent)
            }
        }
    }

    private fun setStarState() {

    }
}