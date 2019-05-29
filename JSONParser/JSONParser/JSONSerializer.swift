import Foundation

struct JSONSerializer {
    
    private (set) var string = ""
    
    private var indentCount = 0
    
    private mutating func insertIndent() {
        string += String(repeating: "    ", count: indentCount)
    }
    
    mutating func serializeJSON(_ JSON: JSONType) {
        
        switch JSON {
        case let array as [JSONType]:
            serializeArray(array)
        case let object as [String: JSONType]:
            serializeObject(object)
        default:
            string += JSON.description
        }
    }
    
    private mutating func serializeArray(_ array: [JSONType]) {
        
        string += "["
        var isFirstValue = true
        
        for item in array {
            if isFirstValue {
                isFirstValue = false
            } else {
                string += ", "
            }
            serializeJSON(item)
        }
        string += "]"
    }
    
    private mutating func serializeObject(_ object: [String: JSONType]) {
        
        string += "{\n"
        insertIndent()
        var isFirstValue = true
        
        indentCount += 1
        
        for (key,value) in object {
            if isFirstValue {
                isFirstValue = false
            } else {
                string += ",\n"
            }
            string += "\(key): \(serializeJSON(value))"
            
        }
        indentCount -= 1
        string += "}"
    }
    
}
