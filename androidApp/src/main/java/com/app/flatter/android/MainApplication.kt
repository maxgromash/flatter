package com.app.flatter.android

import android.app.Application
import com.app.flatter.di.commonModule
import com.app.flatter.di.initKoin
import org.koin.android.ext.koin.androidContext

internal class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        initKoin {
            androidContext(this@MainApplication)
            modules(commonModule)
        }
    }
}