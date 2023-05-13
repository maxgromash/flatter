package com.app.flatter.businessModels

data class ProjectModel(
    val id: String,
    val title: String,
    val description: String,
    val imageURL: String,
    val address: Address,
    val minFlatPrice: Double,
    val nearestTransport: List<NearestTransport>
) {
    data class Address(
       val address: String,
       val coordinates: Coordinates
    ) {
        data class Coordinates(
            val latitude: Double,
            val longitude: Double
        )
    }

    data class NearestTransport(
        val name: String,
        val color: String,
        val time: Int
    )
}
