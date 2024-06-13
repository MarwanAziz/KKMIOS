package com.example.kkmios

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform