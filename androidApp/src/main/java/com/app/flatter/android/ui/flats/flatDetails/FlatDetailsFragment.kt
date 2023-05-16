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


        item?.run {
            binding.mortgage.bind(price.toInt())
            adapterDetails.setItems(images)
            binding.roomMTV.text = number.toString()
            binding.floorMTV.text = floor.toString()
            binding.squareMTV.text = area.toString()
            binding.price.text = "${price.formatBySpace()} Р"
            binding.rooms.text = rooms.toString()
            binding.finishing.text = trimming
            binding.surrender.text = finishing

            binding.starAPIV.setOnClickListener {
                viewModel.setStar(id, isFavourite.not())
            }

            binding.starAPIV.setImageResource(if (isFavourite) R.drawable.ic_baseline_star_24 else R.drawable.ic_baseline_star_border_24)

        }

        val callPerm = android.Manifest.permission.CALL_PHONE

        binding.bookFlat.setOnClickListener {
            if (ContextCompat.checkSelfPermission(requireContext(), callPerm) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(requireActivity(), arrayOf(callPerm), 123)
            } else {
                startActivity(Intent(Intent.ACTION_CALL, Uri.parse("tel:" + "89227045875")))
            }
        }
    }
}