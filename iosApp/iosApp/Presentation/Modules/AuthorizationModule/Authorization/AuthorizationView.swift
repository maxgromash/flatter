import Foundation
import SwiftUI

struct AuthorizationView<
    Router: Routing,
    VM: AuthorizationViewModel
>: AppView where Router.Route == AuthorizationRoute {
    @ObservedObject var viewModel: VM
    let router: Router

    var body: some View {
        BackgroundContainer {
            VStack(alignment: .leading) {
                header
                VStack(alignment: .center) {
                    AuthorizationTextField(title: "Email", text: $viewModel.emailInput)
                        .required(validator: { _ in viewModel.emailValid })
                    AuthorizationTextField(title: "Пароль", text: $viewModel.passwordInput)
                        .secure()
                        .required(validator: { _ in viewModel.passwordValid })
                    signInButton
                    registrationButton
                    passwordRestore
                }
            }
            .padding(.horizontal, 15)
            .alert(viewModel: viewModel)
        }
        .navigationTitle("Авторизация")
        .navigationBarHidden(true)
    }

    @ViewBuilder private var header: some View {
        Text("Добро пожаловать!")
            .font(.largeTitle)
            .foregroundColor(.white)
    }

    @ViewBuilder private var signInButton: some View {
        AuthorizatoinMainActionButton(
            text: "Войти",
            action: viewModel.userDidTapAuthorizationButton,
            disabled: (viewModel.emailValid && viewModel.passwordValid) == false
        )
    }

    @ViewBuilder private var registrationButton: some View {
        Button(
            action: {
                viewModel.userDidTapRegistration()
            },
            label: {
                Text("Зарегистрироваться")
                    .foregroundColor(ColorsProvider.primary)
            }
        )
    }

    @ViewBuilder private var passwordRestore: some View {
        HStack {
            Text("Забыли пароль?")
                .foregroundColor(.white)
            Button("Восстановить", action: viewModel.userDidTapRestorePassword)
                .foregroundColor(ColorsProvider.primary)
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView(
            viewModel: ViewModelMock(),
            router: EmptyViewRouterMock()
        )
    }

    private final class ViewModelMock: AuthorizationViewModel {
        var emailValid: Bool = false

        var passwordValid: Bool = false

        var navigationRoute: AuthorizationRoute? = nil

        var emailInput: String = ""

        var passwordInput: String = ""

        func userDidTapAuthorizationButton() {}

        func userDidTapRegistration() {}

        func userDidTapRestorePassword() {}
    }
}
