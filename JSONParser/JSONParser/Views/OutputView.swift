import Foundation

struct OutputView {
    
    static func showDescription(data: JSONType) {
        print(data.countDescription)
    }
    
    static func showSerializedJSON(data: JSONType) {
        var serializer = JSONSerializer()
        serializer.serializeJSON(data)
        print(serializer.string)
    }
}
