package com.app.flatter.presentation.projects

import com.app.flatter.businessModels.ProjectModel
import com.app.flatter.network.ProjectsClient
import com.app.flatter.presentation.BaseStore
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import models.Address
import models.GetProjectsResponse
import models.NearestTransports
import models.Project
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class ProjectsStore: BaseStore<ProjectsState, ProjectsAction, ProjectsSideEffect>(), KoinComponent {
    override val stateFlow = MutableStateFlow<ProjectsState>(ProjectsState.None)
    override val sideEffectsFlow = MutableSharedFlow<ProjectsSideEffect>()

    private val client: ProjectsClient by inject()

    override suspend fun reduce(action: ProjectsAction, initialState: ProjectsState) {
        coroutineScope {
            when (action) {
                is ProjectsAction.SyncProjects -> processProjectsSync()
            }
        }
    }

    private suspend fun processProjectsSync() {
        sendEffect { ProjectsSideEffect.ShowProgress }
        runCatching {
            client.loadProjects()
        }
            .onSuccess { response ->
                updateState { ProjectsState.ProjectsList(response.toProjectsList()) }
            }
            .onFailure {
                sendEffect { ProjectsSideEffect.ShowMessage("Не удалось загрузить список проектов") }
            }
    }

    private fun GetProjectsResponse.toProjectsList(): List<ProjectModel> {
        return this.projects.map { it.toProjectModel() }
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