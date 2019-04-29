import Foundation

struct StrategySelecter {
    
    private var parsingStrategy: ParsingStrategy! = nil
    
    var result: Type {
        return parsingStrategy.result
    }
    
    
    mutating func parse(_ charcater: Character) throws -> ParsingState {
        if parsingStrategy == nil {
            try detectType(charcater)
        }
        guard parsingStrategy != nil else {
            return ParsingState.isNotDone
        }
        return try parsingStrategy.parse(charcater)
    }
    
    private mutating func detectType(_ character: Character) throws {
        switch character {
        case " ":
            return
        case "\"":
            parsingStrategy = StringParsingStrategy()
        case "t", "f":
            parsingStrategy = BoolParsingStrategy()
        case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            parsingStrategy = NumberParsingStrategy()
        case "[":
            parsingStrategy = ArrayParsingStrategy()
        default:
            throw TypeSeltectionError.unsupportedCharacter
        }
    }
    
    
    
}

enum TypeSeltectionError: Error {
    case unsupportedCharacter
}
