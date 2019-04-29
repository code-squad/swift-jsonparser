import Foundation

struct OutputView {
    
    func printTypeCount(data: [Type]) {
        var counts = [String: Int]()
        
        for datum in data {
            counts[datum.description] = (counts[datum.description] ?? 0) + 1
        }
    }
    
}
