package com.app.flatter.android.main

import android.app.Application
import com.app.flatter.di.commonModule
import com.app.flatter.di.initKoin
import com.app.flatter.di.platformModule
import com.yandex.mapkit.MapKitFactory
import org.koin.android.ext.koin.androidContext

internal class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        initKoin {
            androidContext(this@MainApplication)
            modules(commonModule, platformModule)
            // Init Yandex Maps
            MapKitFactory.setApiKey("454b1f69-7e7b-41e7-8715-e0ec3afa4b98");
            MapKitFactory.initialize(applicationContext)
        }
    }
}