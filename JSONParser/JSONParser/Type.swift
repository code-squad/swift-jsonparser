import Foundation

protocol Type { }

extension Type {
    var description: String {
        switch self {
        case is String:
            return "문자열"
        case is Double:
            return "숫자"
        case is Bool:
            return "부울"
        case is Array<Type>:
            return "배열"
        default:
            return "알 수 없는 유형"
        }
    }
}

extension String: Type { }
extension Double: Type { }
extension Bool: Type { }
extension Array: Type where Element == Type { }

