import Foundation
import shared

struct UserModel: Equatable, Hashable {
    let name: String
    let email: String
    let phoneNumber: String
}

extension UserModel {
    static let mock = UserModel(
        name: "Егор",
        email: "egor@mail.ru",
        phoneNumber: "89999999999"
    )
}


extension UserModel {
    init(_ data: shared.UserModel) {
        self.init(
            name: data.name,
            email: data.email,
            phoneNumber: data.phoneNumber
        )
    }
}
