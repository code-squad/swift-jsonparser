import Foundation

protocol JSONType: CustomStringConvertible {
    var typeDescription: String { get }
    var countDescription: String { get }
}

protocol JSONSingleValueType: JSONType { }

extension JSONSingleValueType {
    var countDescription: String {
        return "총 1개의 데이터 중에 \(self.typeDescription) 1개가 포함되어 있습니다."
    }
}

extension String: JSONSingleValueType {
    var typeDescription: String { return "문자열" }
}

typealias Number = Double
extension Number: JSONSingleValueType {
    var typeDescription: String { return "숫자" }
}

extension Bool: JSONSingleValueType {
    var typeDescription: String { return "부울" }
}

extension Array: JSONType where Element == JSONType {
    
    var typeDescription: String { return "배열" }
    
    var countDescription: String {
        if self.isEmpty {
            return "빈 배열입니다."
        }
        var counts = [String: Int]()
        for item in self {
            counts[item.typeDescription] = (counts[item.typeDescription] ?? 0) + 1
        }
        
        let countsString = counts.map { "\($0.key) \($0.value)개" }
        return "이 배열에는 총 \(self.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다."
    }
    
}

typealias Object = Dictionary
extension Object: JSONType where Key == String ,Value == JSONType {
    
    var typeDescription: String { return "오브젝트" }
    
    var countDescription: String {
        if self.isEmpty {
            return "빈 오브젝트입니다."
        }
        var counts = [String: Int]()
        for (_, value) in self {
            counts[value.typeDescription] = (counts[value.typeDescription] ?? 0) + 1
        }
        
        let countsString = counts.map { "\($0.key) \($0.value)개" }
        return "이 오브젝트에는 총 \(self.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다."
    }
    
}
