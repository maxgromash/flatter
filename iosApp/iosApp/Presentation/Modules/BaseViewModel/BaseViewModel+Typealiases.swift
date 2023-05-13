import Foundation
import shared

typealias AuthStoreViewModel = BaseViewModel<AuthState, AuthAction, AuthSideEffect, AuthStore>

typealias NewsStoreViewModel = BaseViewModel<NewsState, NewsAction, NewsSideEffect, NewsStore>

typealias ProjectsViewModel = BaseViewModel<ProjectsState, ProjectsAction, ProjectsSideEffect, ProjectsStore>
