import Foundation

struct TypeSelectionStrategy {
    
    private var parsingStrategy: ParsingStrategy! = nil
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if parsingStrategy == nil { try detectType(character) }
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
        default:
            throw TypeSeltectionError.unsupportedCharacter
        }
    }
    
    
    
}

enum TypeSeltectionError: Error {
    case unsupportedCharacter
}
