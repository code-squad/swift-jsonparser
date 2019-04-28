import Foundation

struct TypeSelecter {
    
    private var parsingStrategy: ParsingStrategy? = nil
    private var hasDetectedType = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if parsingStrategy == nil { try detectType(character) }
        guard var parsingStrategy = parsingStrategy else {
            return ParsingState.isNotDone
        }
        return try parsingStrategy.parse(character)
    }
    
    private mutating func detectType(_ character: Character) throws {
        switch character {
        case "\"":
            parsingStrategy = StringParsingStrategy()
        case "t", "f":
            parsingStrategy = BoolParsingStrategy()
        case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            parsingStrategy = NumberParsingStrategy()
        case " ":
            return
        case "[":
            parsingStrategy = ArrayParsingStrategy()
        default:
            throw TypeSeltectionError.unsupportedCharacter
        }
        hasDetectedType = true
    }
    
    
    
}

enum TypeSeltectionError: Error {
    case unsupportedCharacter
}
