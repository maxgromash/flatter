package com.app.flatter.android.viewModel

import androidx.lifecycle.LifecycleCoroutineScope
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.app.flatter.android.util.SingleLiveEvent
import com.app.flatter.businessModels.ProjectModel
import com.app.flatter.presentation.projects.ProjectsAction
import com.app.flatter.presentation.projects.ProjectsSideEffect
import com.app.flatter.presentation.projects.ProjectsState
import com.app.flatter.presentation.projects.ProjectsStore
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class ProjectsViewModel : ViewModel() {

    private val store = ProjectsStore()

    private val projectsLiveData = MutableLiveData<List<ProjectModel>>()
    private val progressViewModel = SingleLiveEvent<Boolean>()
    private val showMessageViewModel = SingleLiveEvent<String>()

    fun projectsLiveData(): LiveData<List<ProjectModel>> = projectsLiveData
    fun progressViewModel(): LiveData<Boolean> = progressViewModel
    fun showMessageViewModel(): LiveData<String> = showMessageViewModel

    init {
        getProjects()
    }

    fun getProjectById(id: Int): ProjectModel? {
        return projectsLiveData.value?.find { it.id == id }
    }

    init {
        observeState()
        getProjects()
    }

    private fun getProjects() {
        store.reduce(ProjectsAction.SyncProjects)
    }

    fun launchWhenStartedCollectFlow(lifeCycleScope: LifecycleCoroutineScope) {
        lifeCycleScope.launchWhenStarted {
            store.observeState().collectLatest { state ->
                when (state) {
                    is ProjectsState.ProjectsList -> {
                        progressViewModel.value = false
                        projectsLiveData.value = state.list
                    }

                    else -> {}
                }
            }
        }
    }

    private fun observeState() {
        viewModelScope.launch {
            store.observeSideEffects().collect { effect ->
                when (effect) {
                    is ProjectsSideEffect.ShowMessage -> {
                        progressViewModel.value = false
                        showMessageViewModel.value = effect.message
                    }

                    is ProjectsSideEffect.ShowProgress -> {
                        progressViewModel.value = true
                    }
                }
            }
        }
    }
}