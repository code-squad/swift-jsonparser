import Foundation

struct StringParsingStrategy: ParsingStrategy {
    
    mutating func result() -> Type {
        let result = buffer
        buffer = ""
        hasDetectedString = false
        return result
    }
    
    private var buffer = ""
    private var hasDetectedString = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if hasDetectedString {
            return try appendToBuffer(character)
        } else {
            try detectString(character)
        }
        return ParsingState.isNotDone
    }
    
    
    private mutating func detectString(_ character: Character) throws {
        switch character {
        case "\"":
            hasDetectedString = true
        default:
            throw StringParsingError.cannotDetectFirstDoubleQuotationMark
        }
    }
    
    private mutating func appendToBuffer(_ character: Character) throws -> ParsingState {
        switch character {
        case "\"":
            return ParsingState.isDoneCurrentCharacter
        default:
            buffer.append(character)
            return ParsingState.isNotDone
        }
    }
    
    
}

enum StringParsingError: Error {
    case cannotDetectFirstDoubleQuotationMark
}
