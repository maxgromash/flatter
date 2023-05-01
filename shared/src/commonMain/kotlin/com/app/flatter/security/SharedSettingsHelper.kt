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
            encryptedSettings[TOKEN_NAME] = value
        }

    companion object {
        const val ENCRYPTED_DATABASE_NAME = "ENCRYPTED_SETTINGS"
        const val TOKEN_NAME = "FLATTER_TOKEN"
    }
}