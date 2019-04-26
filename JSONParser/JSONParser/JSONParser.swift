import Foundation

struct JSONParser {
    
    var data = Data()
    
    
    
    
    
    
    
    mutating func parse(JSON: String) {
        
        var buffer = ""
        var isDataToParse = false
        
        for character in JSON {
            
            if character == "," {
                isDataToParse = !isDataToParse
            }
            if isDataToParse {
                buffer.append(character)
            } else {
                data.string.append(buffer)
            }
            
        }
        
    }
    
    
    
    struct StringParser {
        var buffer = ""
        var isDataToParse = false
        var isEscapeSequence = false
        
        mutating func parse(character: Character) -> String? {
            switch character {
            case "\\":
                if isEscapeSequence {
                    buffer.append(character)
                } else {
                    isEscapeSequence = !isEscapeSequence
                }
            case "\"":
                if isEscapeSequence {
                    buffer.append(character)
                    isEscapeSequence = !isEscapeSequence
                } else {
                    isDataToParse = !isDataToParse
                }
            default:
                if isDataToParse {
                    buffer.append(character)
                } else {
                    return buffer
                }
            }
            return nil
        }
    }
    
    
    
}

enum ParsingError: Error {
    case invalidNumber
}
