import Foundation

struct JSONSerializer {
    
    private (set) var serializedJSON = ""
    
    private var indentCount = 0
    
    private mutating func insertIndent() {
        serializedJSON.append(String(repeating: "    ", count: indentCount))
    }
    
    mutating func serializeJSON(_ JSON: JSONType) {
        
        switch JSON {
        case let array as [JSONType]:
            serializeArray(array)
        case let object as [String: JSONType]:
            serializeObject(object)
        default:
            serializedJSON.append(JSON.description)
        }
    }
    
    private mutating func serializeArray(_ array: [JSONType]) {
        
        var result = "["
        var isFirstValue = true
        
        for item in array {
            if isFirstValue {
                isFirstValue = false
            } else {
                result += ", "
            }
            serializeJSON(item)
        }
        result += "]"
    }
    
    private mutating func serializeObject(_ object: [String: JSONType]) {
        
        var result = "{"
        var isFirstValue = true
        
        for (key,value) in object {
            if isFirstValue {
                isFirstValue = false
            } else {
                result += ", "
            }
            insertIndent()
            result += "\(key): \(serializeJSON(value))"
        }
        result += "}"
    }
    
    
    
    
    
}
