package com.app.flatter.presentation.projects

import com.app.flatter.businessModels.ProjectModel
import com.app.flatter.network.ProjectsClient
import com.app.flatter.presentation.BaseStore
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
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
        delay(1000)
        updateState {
            ProjectsState.ProjectsList(
                list = listOf(
                    ProjectModel(
                        id = "1",
                        title = "Первый Дубровский",
                        description = "Примерное описание",
                        imageURL = "https://cdn.pronovostroy.ru/object/2022-06-02/6298c5be2adf03097b03b995/images/6298cd42d5af6.jpg",
                        address = ProjectModel.Address(
                            address = "Москва, ул. 1-й Дубровский проезд, 78/14с12",
                            coordinates = ProjectModel.Address.Coordinates(
                                latitude = 55.724282,
                                longitude = 37.684901
                            )
                        ),
                        minFlatPrice = 11.8,
                        nearestTransport = listOf(
                            ProjectModel.NearestTransport(
                                name = "Волгоградский проспект",
                                color = "#800080",
                                time = 2
                            )
                        )
                    )
                )
            )
        }
    }
}