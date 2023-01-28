package com.example.flatter

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform