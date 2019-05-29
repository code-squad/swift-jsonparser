import Foundation

struct JSONSerializer {
    
    private (set) var string = ""
    
    private var indentCount = 0
    
    private mutating func insertIndent() {
        string += String(repeating: "    ", count: indentCount)
    }
    
    mutating func serializeJSON(_ JSON: JSONType) {
        switch JSON {
        case let str as String:
            string += "\"\(str.description)\""
        case let array as [JSONType]:
            serializeArray(array)
        case let object as [String: JSONType]:
            serializeObject(object)
        default:
            string += JSON.description
        }
    }
    
    private mutating func serializeArray(_ array: [JSONType]) {
        
        var isFirst = true
        let hasStructure = array.contains(typeDescription: array.typeDescription)
        
        if hasStructure {
            insertIndent()
            string += "[\n"
            indentCount += 1
        } else {
            string += "["
        }
        
        for item in array {
            if isFirst {
                isFirst = false
            } else if hasStructure {
                string += ",\n"
            } else {
                string += ", "
            }
            if hasStructure {
                insertIndent()
            }
            serializeJSON(item)
        }
        if hasStructure {
            string += "\n"
            indentCount -= 1
            insertIndent()
            string += "]"
        } else {
            string += "]"
        }
    }
    
    private mutating func serializeObject(_ object: [String: JSONType]) {
        
        var isFirstValue = true
        
        string += "{\n"
        indentCount += 1
        
        for (key,value) in object {
            if isFirstValue {
                isFirstValue = false
            } else {
                string += ",\n"
            }
            insertIndent()
            string += "\"\(key)\": "
            serializeJSON(value)
        }
        string += "\n"
        indentCount -= 1
        insertIndent()
        string += "}"
    }
    
}
