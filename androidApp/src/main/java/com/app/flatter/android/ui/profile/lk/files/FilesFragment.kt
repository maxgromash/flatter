package com.app.flatter.android.ui.profile.lk.files

import android.annotation.SuppressLint
import android.app.Activity.RESULT_OK
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.database.Cursor
import android.net.Uri
import android.os.Bundle
import android.provider.OpenableColumns
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.app.flatter.android.R
import com.app.flatter.android.databinding.FragmentFilesBinding
import com.app.flatter.android.ui.profile.lk.files.adapter.FilesAdapter
import com.app.flatter.android.ui.profile.lk.files.adapter.FilesDecoration

private const val FILES = "MY_FILES"

class FilesFragment : Fragment() {

    private lateinit var binding: FragmentFilesBinding
    private val filesAdapter = FilesAdapter(
        onItemClick = { uri ->
            val share = Intent()
            share.action = Intent.ACTION_SEND
            share.type = "application/pdf"
            share.putExtra(Intent.EXTRA_STREAM, uri)
            try {
                startActivity(Intent.createChooser(share, "Share file"))
            } catch (e: ActivityNotFoundException) {
                Toast.makeText(context, e.toString(), Toast.LENGTH_LONG).show()
            }
        },
        onFullItemClick = { uri ->
            val browserIntent = Intent(Intent.ACTION_VIEW)
            browserIntent.data = uri
            browserIntent.type = "application/pdf"
            browserIntent.flags = Intent.FLAG_ACTIVITY_NO_HISTORY;
            startActivity(browserIntent)
        }
    )

    private var cachedPrefs = mutableSetOf<String>()
    private lateinit var preferences: SharedPreferences

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentFilesBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        preferences = requireActivity().getSharedPreferences("pref", Context.MODE_PRIVATE)
        cachedPrefs = preferences.getStringSet(FILES, mutableSetOf<String>()) as MutableSet<String>
        cachedPrefs.toMutableList().map { FileVo.parseString(it) }.toMutableList().let { filesAdapter.setItems(it) }
        setupUI()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            1 -> {
                if (resultCode === RESULT_OK) {
                    val chosenImageUri: Uri? = data?.data
                    chosenImageUri?.let { uri ->
                        val name = getNameFromURI(uri)
                        val file = FileVo(name!!, uri)
                        filesAdapter.addItem(file)
                        cachedPrefs.add(file.toString())
                        val editor: SharedPreferences.Editor = preferences.edit()
                        editor.putStringSet(FILES, cachedPrefs)
                        editor.apply()
                    }
                }
            }
        }
    }

    private fun setupUI() {
        binding.toolbar.apply {
            setSubtitleTextColor(ContextCompat.getColor(requireContext(), R.color.md_theme_light_onPrimary))
            subtitle = "Назад"
            setNavigationOnClickListener { findNavController().popBackStack() }
        }

        binding.addFileButton.setOnClickListener {
            val intent = Intent(Intent.ACTION_GET_CONTENT)
            intent.type = "application/pdf"
            startActivityForResult(intent, 1)
        }

        with(binding.list) {
            adapter = filesAdapter
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            addItemDecoration(FilesDecoration())
        }
    }

    @SuppressLint("Range")
    private fun getNameFromURI(uri: Uri): String? {
        val contentResolver = binding.root.context.contentResolver
        val c: Cursor? = contentResolver.query(uri, null, null, null, null)
        c?.moveToFirst()
        return c?.getString(c.getColumnIndex(OpenableColumns.DISPLAY_NAME))
    }
}