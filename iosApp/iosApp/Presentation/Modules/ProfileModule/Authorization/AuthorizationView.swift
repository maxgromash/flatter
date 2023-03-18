import Foundation
import SwiftUI

struct AuthorizationView<
    Router: Routing,
    VM: AuthorizationViewModel
>: AppView where Router.Route == AuthorizationRoute {
    @ObservedObject var viewModel: VM
    let router: Router

    var body: some View {
        backgroundContainer {
            VStack(alignment: .leading) {
                header
                VStack(alignment: .center) {
                    AuthorizationTextField(title: "Email", text: $viewModel.emailInput)
                    AuthorizationTextField(title: "Пароль", text: $viewModel.passwordInput, isSecure: true)
                    signInButton
                    registrationButton
                }
            }
            .padding(.horizontal, 15)
        }
    }

    @ViewBuilder private func backgroundContainer(content: @escaping () -> some View) -> some View {
        GeometryReader { reader in
            ZStack {
                ImagesProvider.buildingBackground
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(reader.size, contentMode: .fill)
                    .blur(radius: 8)
                content()
            }
        }
    }

    @ViewBuilder private var header: some View {
        Text("Добро пожаловать!")
            .font(.largeTitle)
            .foregroundColor(.white)
    }

    @ViewBuilder private var signInButton: some View {
        Button(
            action: {},
            label: {
                Text("Войти")
                    .foregroundColor(.white)
            }
        )
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
        .background(ColorsProvider.primary)
        .roundedBorder(.clear, cornerRadius: 15)
    }

    @ViewBuilder private var registrationButton: some View {
        Button(
            action: {
                viewModel.userDidTapRegistration()
            },
            label: {
                Text("Зарегистрироваться")
                    .foregroundColor(.white)
            }
        )
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView(
            viewModel: ViewModelMock(),
            router: RouterMock()
        )
    }

    private final class ViewModelMock: AuthorizationViewModel {
        var navigationRoute: AuthorizationRoute? = nil

        var emailInput: String = ""

        var passwordInput: String = ""

        func userDidTapRegistration() {}
    }

    private struct RouterMock: Routing {
        @ViewBuilder func view(for route: AuthorizationRoute) -> some View {
            EmptyView()
        }
    }
}
