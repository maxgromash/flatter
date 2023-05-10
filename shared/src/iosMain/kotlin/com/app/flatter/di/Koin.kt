package com.app.flatter.di

import com.app.flatter.network.AuthClient
import org.koin.core.module.Module
import org.koin.dsl.module

actual val platformModule: Module = module(createdAtStart = true) {
}