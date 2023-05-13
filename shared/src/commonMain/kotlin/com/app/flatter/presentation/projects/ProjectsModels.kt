package com.app.flatter.presentation.projects

import com.app.flatter.businessModels.ProjectModel

sealed interface ProjectsState {
    object None : ProjectsState
    data class ProjectsList(
        val list: List<ProjectModel>
    ) : ProjectsState
}

sealed interface ProjectsAction {
    object SyncProjects : ProjectsAction
}

sealed interface ProjectsSideEffect {
    object ShowProgress: ProjectsSideEffect

    data class ShowMessage(val message: String) : ProjectsSideEffect
}