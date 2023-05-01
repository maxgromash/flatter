import Foundation

struct PasswordValidator {
    static func validate(password: String) -> Bool {
        password.count > 8
    }
}
