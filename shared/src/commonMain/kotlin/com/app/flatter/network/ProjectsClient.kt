package com.app.flatter.network

interface ProjectsClient {
    suspend fun loadProjects()
}