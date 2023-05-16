package com.app.flatter.android.main

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.NavigationUI
import com.app.flatter.android.R
import com.app.flatter.android.databinding.ActivityMainBinding
import com.app.flatter.android.viewModel.AuthViewModel
import com.app.flatter.network.AuthClientImpl
import com.app.flatter.network.FavouriteFlatsClientImpl
import com.app.flatter.network.FlatsClientImpl
import com.app.flatter.network.NetworkClientsProvider
import com.app.flatter.network.NewsClientImpl
import com.app.flatter.network.ProjectsClientImpl

internal class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        val navHostFragment = supportFragmentManager.findFragmentById(R.id.fragmentContainerFCV) as NavHostFragment
        val navController = navHostFragment.navController
        NavigationUI.setupWithNavController(binding.bottomNavigationBNV, navController)
        NetworkClientsProvider.authClient = AuthClientImpl()
        NetworkClientsProvider.newsClient = NewsClientImpl()
        NetworkClientsProvider.projectsClient = ProjectsClientImpl()
        NetworkClientsProvider.flatsClient = FlatsClientImpl()
        NetworkClientsProvider.favouriteFlatsClient = FavouriteFlatsClientImpl()
    }

    override fun onStart() {
        super.onStart()
        val x = ViewModelProvider(this)[AuthViewModel::class.java]
    }
}