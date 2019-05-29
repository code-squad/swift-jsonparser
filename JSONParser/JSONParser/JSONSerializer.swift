import Foundation

struct JSONSerializer {
    
    var indentCount = 0
    
    func serializeJSON(_ JSON: JSONType) -> String {
        
        var result = ""
        
        switch JSON {
        case let array as [JSONType]:
            result.append(serializeArray(array))
        case let object as [String: JSONType]:
            result.append(serializeObject(object))
        default:
            result.append(JSON.description)
        }
        
        return result
    }
    
    private func serializeArray(_ array: [JSONType]) -> String {
        
        var result = String("[")
        var isFirstElement = true
        
        for item in array {
            if isFirstElement {
                isFirstElement = false
            } else {
                result.append(", ")
            }
            result.append(serializeJSON(item))
        }
        result.append("]")
        return result
    }
    
    private func serializeObject(_ object: [String: JSONType]) -> String {
        
        var result = ""
        
        return result
    }
}
