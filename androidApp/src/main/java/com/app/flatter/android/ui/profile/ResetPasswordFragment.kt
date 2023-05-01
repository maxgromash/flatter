package com.app.flatter.android.ui.profile

import android.os.Bundle
import android.telephony.PhoneNumberFormattingTextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentResetPasswordBinding
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


class ResetPasswordFragment : Fragment() {

    private lateinit var binding: FragmentResetPasswordBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentResetPasswordBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.toolBarTB.setNavigationIcon(R.drawable.ic_round_arrow_back_24_white);
        binding.toolBarTB.subtitle = "Назад"
        binding.toolBarTB.setNavigationOnClickListener {
            findNavController().popBackStack()
        }

        binding.button.setOnClickListener {
            binding.loadingProgressCPI.visibility = View.VISIBLE
            binding.button.text = ""
            lifecycleScope.launch {
                delay(500)
                binding.button.text = "Зарегистрироваться"
                binding.loadingProgressCPI.visibility = View.GONE
                Toast.makeText(context, "Отправили письмо для восстановления пароля", Toast.LENGTH_SHORT).show()
            }
        }
    }
}