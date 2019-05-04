import Foundation

struct StrategySelecter: ParsingStrategy {
    
    private(set) var parsingStrategy: ParsingStrategy!
    
    
    mutating func result() throws -> Type {
        let result = try parsingStrategy.result()
        parsingStrategy = nil
        return result
    }
    
    mutating func parse(_ charcater: Character) throws -> ParsingState {
        if parsingStrategy == nil {
            return try detectType(charcater)
        }
        guard parsingStrategy != nil else {
            return ParsingState.isNotDone
        }
        return try parsingStrategy.parse(charcater)
    }
    
    enum Parser: CaseIterable {
        case array
        case string
        case bool
        case number
        case object
        var strategy: ParsingStrategy {
            switch self {
            case .array: return ArrayParsingStrategy()
            case .string: return StringParsingStrategy()
            case .bool: return BoolParsingStrategy()
            case .number: return NumberParsingStrategy()
            case .object: return ObjectParsingStrategy()
            }
        }
    }
    
    private mutating func detectType(_ character: Character) throws -> ParsingState {
        if character == " " { return ParsingState.isNotDone }
        
        for strategy in Parser.allCases {
            var parsingStrategy = strategy.strategy
            if let state = try? parsingStrategy.parse(character) {
                self.parsingStrategy = parsingStrategy
                return state
            }
        }
        
        throw TypeSeltectionError.unsupportedCharacter
    }
    
}

enum TypeSeltectionError: Error {
    case unsupportedCharacter
}
