package com.app.flatter.security

import com.russhwolf.settings.Settings
import com.russhwolf.settings.set

class SharedSettingsHelper(
    private val encryptedSettings: Settings,
) {
    var token: String?
        get() {
            return encryptedSettings.getStringOrNull(TOKEN_NAME)
        }
        set(value) {
            encryptedSettings.set(TOKEN_NAME, value)
        }

    companion object {
        const val DATABASE_NAME = "UNENCRYPTED_SETTINGS"
        const val ENCRYPTED_DATABASE_NAME = "ENCRYPTED_SETTINGS"
        const val encryptedSettingsName = "encryptedSettings"
        const val unencryptedSettingsName = "unencryptedSettings"
        const val TOKEN_NAME = "TOKEN"
    }
}