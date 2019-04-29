import Foundation

struct OutputView {
    
    static func printTypeCount(data: Type) {
        
        if data is Array<Type> {
            let data = data as! Array<Type>
            var counts = [String: Int]()
            for item in data {
                counts[item.description] = (counts[item.description] ?? 0) + 1
            }
            
            var countsString = [String]()
            for (type, count) in counts {
                countsString.append("\(type) \(count)개")
            }
            
            print("총 \(data.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다.")
        } else {
            print("총 1개의 데이터 중에 \(data.description) 1개가 포함되어 있습니다.")
        }
        
    }
    
}
