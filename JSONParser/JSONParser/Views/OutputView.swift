import Foundation

struct OutputView {
    
    static func showDescription(data: JSONType) {
        print(data.countDescription)
    }
    
    static func showSerializedJSON(data: JSONType) {
        print(data.serialized())
    }
}
