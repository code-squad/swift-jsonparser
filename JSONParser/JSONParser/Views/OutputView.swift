import Foundation

struct OutputView {
    
    
    
    static func printTypeCount(data: Type) {
        
        switch data {
        case let data as Array<Type> where !data.isEmpty:
            printArrayCount(data)
        case let data as Dictionary<String, Type> where !data.isEmpty:
            printObjectCount(data)
        default:
            print("총 1개의 데이터 중에 \(data) 1개가 포함되어 있습니다.")
        }
        
    }
    
    
    
    private static func printArrayCount(_ data: [Type]) {
        var counts = [String: Int]()
        for item in data {
            counts[item.description] = (counts[item.description] ?? 0) + 1
        }
        
        var countsString = [String]()
        for (type, count) in counts {
            countsString.append("\(type) \(count)개")
        }
        
        print("총 \(data.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다.")
    }
    
    private static func printObjectCount(_ data: [String: Type]) {
        var counts = [String: Int]()
        for (string, value) in data {
            counts[value.description] = (counts[value.description] ?? 0) + 1
        }
        
        var countsString = [String]()
        for (type, count) in counts {
            countsString.append("\(type) \(count)개")
        }
        
        print("총 \(data.count)개의 객체 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다.")
    }
    
}
