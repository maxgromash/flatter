package com.app.flatter.security

import android.content.Context
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import com.russhwolf.settings.SharedPreferencesSettings
import com.russhwolf.settings.Settings
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

actual class EncryptedSettingsHolder: KoinComponent {
    val context: Context by inject()
    actual val encryptedSettings: Settings = SharedPreferencesSettings(EncryptedSharedPreferences.create(
        context,
        SharedSettingsHelper.ENCRYPTED_DATABASE_NAME,
        MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build(),
        EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
        EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    ), false)
}