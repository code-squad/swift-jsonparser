import Foundation

struct StringParsingStrategy: ParsingStrategy {
    
    mutating func result() throws -> Type {
        guard !isParsingString else {
            throw StringParsingError.parsingNotComplete
        }
        let result = buffer
        buffer = ""
        return result
    }
    
    private var buffer = ""
    private var isParsingString = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if isParsingString {
            return try appendToBuffer(character)
        } else {
            try detectString(character)
        }
        return .isNotDone
    }
    
    
    private mutating func detectString(_ character: Character) throws {
        switch character {
        case " ":
            return
        case "\"":
            isParsingString = true
        default:
            throw StringParsingError.cannotDetectFirstDoubleQuotationMark
        }
    }
    
    private mutating func appendToBuffer(_ character: Character) throws -> ParsingState {
        switch character {
        case "\"":
            isParsingString = false
            return .isDoneCurrentCharacter
        default:
            buffer.append(character)
            return .isNotDone
        }
    }
    
    
}

enum StringParsingError: Error {
    case cannotDetectFirstDoubleQuotationMark
    case parsingNotComplete
}
