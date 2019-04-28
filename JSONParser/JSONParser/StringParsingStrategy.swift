import Foundation

struct StringParsingStrategy {
    
    private var buffer = ""
    private var stringDetected = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if stringDetected {
            return try appendString(character)
        } else {
            try detectString(character)
        }
        return ParsingState.isNotDone
    }
    
    
    private mutating func detectString(_ character: Character) throws {
        switch character {
        case "\"":
            stringDetected = true
        default:
            throw StringParsingError.cannotDetectFirstDoubleQuotationMark
        }
    }
    
    private mutating func appendString(_ character: Character) throws -> ParsingState {
        switch character {
        case "\"":
            let result = buffer
            return ParsingState.isDoneCurrentCharacter(result: result)
        default:
            buffer.append(character)
            return ParsingState.isNotDone
        }
    }
    
    
}

enum StringParsingError: Error {
    case cannotDetectFirstDoubleQuotationMark
}
