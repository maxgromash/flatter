package com.app.flatter.mapper

import com.app.flatter.businessModels.ProjectModel
import models.Address
import models.NearestTransports
import models.Project

class ProjectsMapper: BaseMapper<List<Project>, List<ProjectModel>> {
    override fun invoke(state: List<Project>): List<ProjectModel> {
        return state.map { it.toProjectModel() }
    }

    private fun Project.toProjectModel(): ProjectModel {
        return ProjectModel(
            id = this.id,
            title = this.title,
            description = this.description,
            imageURL = this.images.first(),
            address = this.address!!.toProjectAddress(),
            minFlatPrice = this.minFlatPrice,
            nearestTransport = this.nearestTransports.map { it.toProjectTransport() }
        )
    }

    private fun Address.toProjectAddress(): ProjectModel.Address {
        return ProjectModel.Address(
            address = this.address,
            coordinates = ProjectModel.Address.Coordinates(
                longitude = this.coordinates!!.longitude,
                latitude = this.coordinates!!.latitude
            )
        )
    }

    private fun NearestTransports.toProjectTransport(): ProjectModel.NearestTransport {
        return ProjectModel.NearestTransport(
            name = this.name,
            color = "#088000",
            time = this.time
        )
    }
}