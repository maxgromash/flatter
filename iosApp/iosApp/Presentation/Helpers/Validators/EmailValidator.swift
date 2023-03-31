import Foundation

struct EmailValidator {
    static func validate(email: String) -> Bool {
        guard let regex = try? NSRegularExpression(
            pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        ) else {
            return false
        }

        return regex.firstMatch(
            in: email,
            range: NSRange(location: 0, length: email.count)
        ) != nil
    }
}
