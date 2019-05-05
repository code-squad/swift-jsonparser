import Foundation

struct StrategySelecter: ParsingStrategy {
    
    private(set) var parsingStrategy: ParsingStrategy!
    
    
    mutating func result() throws -> Type {
        let result = try parsingStrategy.result()
        parsingStrategy = nil
        return result
    }
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if parsingStrategy == nil {
            return try detectType(character)
        }
        guard parsingStrategy != nil else {
            return ParsingState.isNotDone
        }
        return try parsingStrategy.parse(character)
    }
    
    
    private mutating func detectType(_ character: Character) throws -> ParsingState {
        
        switch character {
        case " ":
            return ParsingState.isNotDone
        case "[":
            parsingStrategy = ArrayParsingStrategy()
        case "{":
            parsingStrategy = ObjectParsingStrategy()
        case "\"":
            parsingStrategy = StringParsingStrategy()
        case "t", "f":
            parsingStrategy = BoolParsingStrategy()
        case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            parsingStrategy = NumberParsingStrategy()
        default:
            throw TypeSeltectionError.unsupportedCharacter
        }
        return try parsingStrategy.parse(character)
        
    }
    
}

enum TypeSeltectionError: Error {
    case unsupportedCharacter
}
