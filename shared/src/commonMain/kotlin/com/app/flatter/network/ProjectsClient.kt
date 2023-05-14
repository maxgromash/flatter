package com.app.flatter.network

import models.GetProjectsResponse

interface ProjectsClient {
    suspend fun loadProjects(): GetProjectsResponse
}