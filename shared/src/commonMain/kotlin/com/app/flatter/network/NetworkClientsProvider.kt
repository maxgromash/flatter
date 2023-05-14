package com.app.flatter.network

object NetworkClientsProvider {
    lateinit var authClient: AuthClient
    lateinit var newsClient: NewsClient
    lateinit var projectsClient: ProjectsClient
    lateinit var flatsClient: FlatsClient
    lateinit var favouriteFlatsClient: FavouriteFlatsClient
}