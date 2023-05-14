package com.app.flatter.presentation.projects

import com.app.flatter.mapper.ProjectsMapper
import com.app.flatter.network.ProjectsClient
import com.app.flatter.presentation.BaseStore
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class ProjectsStore : BaseStore<ProjectsState, ProjectsAction, ProjectsSideEffect>(), KoinComponent {
    override val stateFlow = MutableStateFlow<ProjectsState>(ProjectsState.None)
    override val sideEffectsFlow = MutableSharedFlow<ProjectsSideEffect>()

    private val client: ProjectsClient by inject()
    private val mapper: ProjectsMapper by inject()

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
        }.onSuccess { response ->
            val mapped = mapper.invoke(response.projects)
            updateState { ProjectsState.ProjectsList(mapped) }
        }.onFailure {
            sendEffect { ProjectsSideEffect.ShowMessage("Не удалось загрузить список проектов") }
        }
    }
}