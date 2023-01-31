package com.app.flatter.services.network

import org.koin.core.qualifier.Qualifier
import org.koin.core.qualifier.QualifierValue

internal object HostQualifier : Qualifier {
    // TODO: set to real backend endpoint
    override val value: QualifierValue
        get() = "http://127.0.0.1:8080"
}