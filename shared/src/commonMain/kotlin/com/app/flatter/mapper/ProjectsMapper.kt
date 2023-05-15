package com.app.flatter.mapper

import com.app.flatter.businessModels.ProjectModel
import models.Address
import models.NearestTransports
import models.Project

class ProjectsMapper : BaseMapper<List<Project>, List<ProjectModel>> {
    override fun invoke(state: List<Project>): List<ProjectModel> {
        return state.map { it.toProjectModel() }
    }

    private fun Project.toProjectModel(): ProjectModel {
        return ProjectModel(
            id = id,
            title = title,
            description = description,
            imageURL = images.first(),
            address = this.address!!.toProjectAddress(),
            minFlatPrice = minFlatPrice,
            nearestTransport = nearestTransports.map(::mapProjectTransport)
        )
    }

    private fun Address.toProjectAddress(): ProjectModel.Address {
        return ProjectModel.Address(
            address = address,
            coordinates = ProjectModel.Address.Coordinates(
                longitude = coordinates!!.longitude,
                latitude = coordinates.latitude
            )
        )
    }

    private fun mapProjectTransport(dto: NearestTransports) = with(dto) {
        ProjectModel.NearestTransport(
            name = name,
            color = color,
            time = time
        )
    }
}