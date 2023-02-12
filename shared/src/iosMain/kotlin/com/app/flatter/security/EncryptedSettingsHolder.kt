package com.app.flatter.security

import com.russhwolf.settings.KeychainSettings
import com.russhwolf.settings.Settings

actual class EncryptedSettingsHolder {
    actual val encryptedSettings: Settings = KeychainSettings(service = SharedSettingsHelper.ENCRYPTED_DATABASE_NAME)
}