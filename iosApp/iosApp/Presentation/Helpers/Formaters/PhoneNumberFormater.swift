import Foundation

final class PhoneNumberFormatter {
    static func format(phoneNumber: String) -> String {
        var _number = phoneNumber
        if _number.hasPrefix("8") {
            _ = _number.removeFirst()
            _number = "7\(_number)"
        }

        _number = format(with: "+X (XXX) XXX-XX-XX", phone: _number)
        guard _number.hasPrefix("+7") || _number.isEmpty else {
            return phoneNumber
        }

        return _number
    }

    private static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}
