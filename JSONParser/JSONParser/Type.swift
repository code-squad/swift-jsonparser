import Foundation

protocol Type {
    var typeDescription: String { get }
}

extension String: Type {
    var typeDescription: String { return "문자열" }
}
extension Double: Type {
    var typeDescription: String { return "숫자" }
}
extension Bool: Type {
    var typeDescription: String { return "부울" }
}
extension Array: Type where Element == Type {
    var typeDescription: String { return "배열" }
}
extension Dictionary: Type where Key == String ,Value == Type {
    var typeDescription: String { return "오브젝트" }
}
