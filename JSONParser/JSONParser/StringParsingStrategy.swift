import Foundation

struct StringParsingStrategy: ParsingStrategy {
    
    private var buffer = ""
    private var hasDetectedString = false
    
    var result: Type {
        return Type.string(buffer)
    }
    
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
