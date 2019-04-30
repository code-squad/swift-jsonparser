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
    
    
    private func loopParsingStrategy(index: Int) -> ParsingStrategy? {
        switch index {
        case 1:
            return ArrayParsingStrategy()
        case 2:
            return StringParsingStrategy()
        case 3:
            return BoolParsingStrategy()
        case 4:
            return NumberParsingStrategy()
        default:
            return nil
        }
    }
    
    private mutating func detectType(_ character: Character) throws -> ParsingState {
        if character == " " { return ParsingState.isNotDone }
        
        for index in 1...4 {
            guard var parsingStrategy = loopParsingStrategy(index: index) else {
                throw TypeSeltectionError.invalidIndex
            }
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
    case invalidIndex
}
