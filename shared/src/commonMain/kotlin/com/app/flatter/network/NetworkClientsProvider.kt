package com.app.flatter.network

import com.app.flatter.presentation.BaseStore
import com.app.flatter.presentation.auth.AuthStore
import kotlin.reflect.KClass

object NetworkClientsProvider {
    lateinit var authClient: AuthClient
    lateinit var newsClient: NewsClient
}