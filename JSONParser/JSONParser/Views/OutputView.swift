import Foundation

struct OutputView {
    
    static func printTypeCount(data: [Type]) {
        
        var counts = [String: Int]()
        for datum in data {
            counts[datum.description] = (counts[datum.description] ?? 0) + 1
        }
        
        var countsString = [String]()
        for (type, count) in counts {
            countsString.append("\(type) \(count)개")
        }
        
        print("총 \(data.count)개의 데이터 중에 \(countsString.joined(separator: ", "))가 포함되어 있습니다.")
        
    }
    
}
