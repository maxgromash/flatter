package com.app.flatter.android.ui.profile.auth

import android.os.Bundle
import android.telephony.PhoneNumberFormattingTextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentRegistrationBinding
import com.app.flatter.android.util.hideKeyboard
import com.app.flatter.android.viewModel.AuthViewModel
import kotlinx.coroutines.launch

class RegistrationFragment : Fragment() {

    private lateinit var binding: FragmentRegistrationBinding
    private lateinit var viewModel: AuthViewModel

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentRegistrationBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(requireActivity())[AuthViewModel::class.java]

        binding.toolBarTB.setNavigationIcon(R.drawable.ic_round_arrow_back_24_white)
        binding.toolBarTB.subtitle = "Назад"
        binding.toolBarTB.setNavigationOnClickListener {
            findNavController().popBackStack()
        }
        binding.phoneTIET.addTextChangedListener(PhoneNumberFormattingTextWatcher("RU"))

        binding.registrarionButtomMB.setOnClickListener {
            viewModel.signUp(
                phone = binding.phoneTIET.text.toString(),
                email = binding.loginTIET.text.toString(),
                name = binding.nameTIET.text.toString(),
                password = binding.passwordTIET.text.toString(),
                passwordConfirm = binding.passwordTwoTIET.text.toString()
            )
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
                binding.loadingProgressCPI.visibility = View.VISIBLE
                binding.registrarionButtomMB.text = ""
            } else {
                binding.loadingProgressCPI.visibility = View.GONE
                binding.registrarionButtomMB.text = "Зарегистрироваться"
            }
        }

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                viewModel.launchWhenStartedCollectFlow(lifecycleScope)
            }
        }
    }
}