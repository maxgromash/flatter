import SwiftUI

struct ProjectsListView<
    VM: ProjectsListViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    @ObservedObject var viewModel: VM
    let router: Router

    var body: some View {
        BackgroundContainer {
            ScrollView {
                ForEach(viewModel.projects, id: \.id) { project in
                    ProjectsListCard(
                        project: project
                    )
                    .padding(.bottom, project.id == viewModel.projects.last?.id ? 0 : 10)
                    .onTapGesture {
                        viewModel.onUserDidTapProjectCard(project: project)
                    }
                }
                .padding(.horizontal, 20)
            }
            .safeAreaInset(edge: .bottom) {
                EmptyView().frame(height: 20)
            }
        }
        .navigationTitle("Проекты")
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProjectsListView(
                viewModel: ViewModelMock(),
                router: EmptyViewRouterMock()
            )
        }
    }

    private final class ViewModelMock: ProjectsListViewModel {
        var navigationRoute: ProjectsListRoute? = nil
        var projects: [ProjectModel] = .mock

        func onUserDidTapProjectCard(project: ProjectModel) {}
    }
}
