import Foundation

protocol Type {
    var typeDescription: String { get }
}

protocol ElementCountable {
    var countDescription: String { get }
}

extension String: Type {
    var typeDescription: String { return "문자열" }
}

typealias Number = Double
extension Number: Type {
    var typeDescription: String { return "숫자" }
}

extension Bool: Type {
    var typeDescription: String { return "부울" }
}

extension Array: Type, ElementCountable where Element == Type {
    
    var typeDescription: String { return "배열" }
    
    var countDescription: String {
        var counts = [String: Int]()
        for item in self {
            counts[item.typeDescription] = (counts[item.typeDescription] ?? 0) + 1
        }
        
        let countsString = counts.map { "\($0.key) \($0.value)개" }
        return "이 배열에는 총 \(self.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다."
    }
    
}

extension Dictionary: Type, ElementCountable where Key == String ,Value == Type {
    
    var typeDescription: String { return "오브젝트" }
    
    var countDescription: String {
        
        var counts = [String: Int]()
        for (_, value) in self {
            counts[value.typeDescription] = (counts[value.typeDescription] ?? 0) + 1
        }
        
        let countsString = counts.map { "\($0.key) \($0.value)개" }
        return "이 오브젝트에는 총 \(self.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다."
    }
    
}
