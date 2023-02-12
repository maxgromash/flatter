package com.app.flatter.security

import com.russhwolf.settings.Settings
import com.russhwolf.settings.set

expect class EncryptedSettingsHolder() {
    val encryptedSettings: Settings
}
