import Foundation
import shared

typealias AuthStoreViewModel = BaseViewModel<AuthState, AuthAction, AuthSideEffect, AuthStore>

typealias NewsStoreViewModel = BaseViewModel<NewsState, NewsAction, NewsSideEffect, NewsStore>

typealias ProjectsViewModel = BaseViewModel<ProjectsState, ProjectsAction, ProjectsSideEffect, ProjectsStore>

typealias FlatsViewModel = BaseViewModel<FlatsState, FlatsAction, FlatsSideEffect, FlatsStore>

typealias FavouritesStoreViewModel = BaseViewModel<FavouriteFlatsState, FavouriteFlatsAction, FavouriteFlatsSideEffect, FavouriteFlatsStore>
