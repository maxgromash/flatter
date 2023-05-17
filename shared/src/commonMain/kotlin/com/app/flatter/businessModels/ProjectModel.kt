package com.app.flatter.businessModels

data class ProjectModel(
    val id: Int,
    val title: String,
    val description: String,
    val imageURL: String,
    val address: Address,
    val minFlatPrice: Double,
    val nearestTransport: List<NearestTransport>,
    val streamResolution: StreamResolution
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

    data class StreamResolution(
        val high: String,
        val standard: String,
        val low: String
    )
}
