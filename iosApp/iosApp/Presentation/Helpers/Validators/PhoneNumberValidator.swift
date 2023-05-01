import Foundation

final class PhoneNumberValidator {
    static func validate(phoneNumber: String) -> Bool {
        let _phoneNumber = phoneNumber
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
        return _phoneNumber.hasPrefix("79") && _phoneNumber.count == 11
    }
}
