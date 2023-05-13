package com.app.flatter.android.main

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.NavigationUI
import com.app.flatter.android.R
import com.app.flatter.android.databinding.ActivityMainBinding
import com.app.flatter.network.AuthClientImpl
import com.app.flatter.network.NetworkClientsProvider

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
        //NetworkClientsProvider.newsClient = NewsClientImpl()
        //NetworkClientsProvider.projectsClient = ProjectsClientImpl()
    }
}