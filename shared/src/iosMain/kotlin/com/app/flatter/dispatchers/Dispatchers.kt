package com.app.flatter.dispatchers

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlin.coroutines.CoroutineContext


actual val ioDispatcher: CoroutineContext
    get() = Dispatchers.Default

actual val uiDispatcher: CoroutineContext
    get() = Dispatchers.Main
