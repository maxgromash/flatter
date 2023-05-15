package com.app.flatter.android.ui.profile.lk

import android.os.Bundle
import android.telephony.PhoneNumberFormattingTextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentChangePersonalDataBinding
import com.app.flatter.android.util.hideKeyboard
import com.app.flatter.android.viewModel.AuthViewModel
import kotlinx.coroutines.launch

class ChangePersonalDataFragment : Fragment() {

    private lateinit var binding: FragmentChangePersonalDataBinding
    private lateinit var viewModel: AuthViewModel

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentChangePersonalDataBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        viewModel = ViewModelProvider(requireActivity())[AuthViewModel::class.java]
        super.onViewCreated(view, savedInstanceState)

        binding.toolBarTB.setNavigationIcon(R.drawable.ic_round_arrow_back_24_white)
        binding.toolBarTB.subtitle = "Назад"
        binding.toolBarTB.setNavigationOnClickListener {
            findNavController().popBackStack()
        }
        binding.phoneTIET.addTextChangedListener(PhoneNumberFormattingTextWatcher("RU"))

        binding.phoneSubmitMB.setOnClickListener {
            viewModel.changePhone(binding.phoneTIET.text.toString())
            hideKeyboard()
        }

        binding.passSubmitMB.setOnClickListener {
            viewModel.changePassword(binding.passTIET.text.toString(), binding.pass2TIET.text.toString())
            hideKeyboard()
        }

        observeState()
    }


    private fun observeState() {

        viewModel.showMessageViewModel().observe(viewLifecycleOwner){message ->
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }

        viewModel.progressViewModel().observe(viewLifecycleOwner) { isProgressVisible ->
            if (isProgressVisible) {
                binding.loadingCPI.visibility = View.VISIBLE
            } else {
                binding.loadingCPI.visibility = View.GONE
            }
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.launchWhenStartedCollectFlow(lifecycleScope)
            }
        }
    }
}