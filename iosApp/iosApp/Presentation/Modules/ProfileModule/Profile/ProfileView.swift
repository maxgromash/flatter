import SwiftUI

struct ProfileView<
    VM: ProfileViewModel,
    Router: Routing
>: AppView where VM.Route == Router.Route {
    var viewModel: VM
    var router: Router

    var body: some View {
        BackgroundContainer {
            VStack {
                headerBlock
                    .frame(height: 150)
                    .padding(.horizontal, 15)
                menuItems
            }
        }
        .navigationTitle("Профиль")
        .navigationBarBackButtonHidden()
    }

    @ViewBuilder private var headerBlock: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            Text("Здравствуйте, \(viewModel.user.name)!")
                .font(.largeTitle)
                .foregroundColor(.white)
            Spacer()
            Text(viewModel.user.email)
                .foregroundColor(.white)
                .font(.title2)
            Text(viewModel.user.phoneNumber)
                .foregroundColor(.white)
                .font(.title2)
        }
    }

    @ViewBuilder private var menuItems: some View {
        VStack(spacing: 20) {
            menuItem(
                icon: ImagesProvider.favouritesIcon,
                text: "Избранное"
            )
            .onTapGesture(perform: viewModel.userDidTapFavouritesList)
            menuItem(
                icon: ImagesProvider.documentIcon,
                text: "Мои документы"
            )
            .onTapGesture(perform: viewModel.userDidTapDocumentsList)
            menuItem(
                icon: ImagesProvider.editIcon,
                text: "Изменить данные"
            )
            .onTapGesture(perform: viewModel.userDidTapProfileChangeButton)
            menuItem(
                icon: ImagesProvider.phoneIcon,
                text: "Связаться с менеджером",
                showNavigationArrow: false
            )
            .onTapGesture(perform: viewModel.userDidTapCallButton)
            exitButton
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 15)
        .background(.white)
        .cornerRadius(15, corners: [.topLeft, .topRight])
    }

    @ViewBuilder private func menuItem(
        icon: Image,
        text: String,
        showNavigationArrow: Bool = true
    ) -> some View {
        VStack {
            HStack {
                icon
                    .foregroundColor(ColorsProvider.primary)
                    .frame(width: 30)
                Text(text)
                    .foregroundColor(ColorsProvider.primary)
                    .font(.title3)
                Spacer()
                if showNavigationArrow {
                    ImagesProvider.rightArrow
                }
            }
            Divider()
        }
    }

    @ViewBuilder private var exitButton: some View {
        Button(
            action: viewModel.userDidTapLogOutButton,
            label: {
                Text("Выйти")
                    .font(.title2)
                    .foregroundColor(ColorsProvider.primary)
            }
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            viewModel: ViewModelMock(),
            router: EmptyViewRouterMock()
        )

    }

    private final class ViewModelMock: ProfileViewModel {
        var user: UserModel = .mock
        
        var navigationRoute: ProfileRoute? = nil

        func userDidTapLogOutButton() {}

        func userDidTapFavouritesList() {}

        func userDidTapDocumentsList() {}

        func userDidTapProfileChangeButton() {}

        func userDidTapCallButton() {}
    }
}
