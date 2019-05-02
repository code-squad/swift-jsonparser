import Foundation

protocol Type { var description: String { get } }

extension String: Type {
    var description: String { return "문자열" }
}
extension Double: Type {
    var description: String { return "숫자" }
}
extension Bool: Type {
    var description: String { return "부울" }
}
extension Array: Type where Element == Type {
    var description: String { return "배열" }
}
extension Dictionary: Type where Value == Type {
    var description: String { return "오브젝트" }
}
