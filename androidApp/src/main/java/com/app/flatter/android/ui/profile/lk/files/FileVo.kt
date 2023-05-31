package com.app.flatter.android.ui.profile.lk.files

import android.net.Uri

data class FileVo(
    val name: String,
    val uri: Uri
) {
    override fun toString(): String {
        return "${name}$$$$${uri}"
    }

    companion object {
        fun parseString(str: String): FileVo {
            val split = str.split("\$\$\$\$")
            val name = split[0]
            val ur = split[1]
            val uri = Uri.parse(ur)
            return FileVo(name, uri)
        }
    }
}