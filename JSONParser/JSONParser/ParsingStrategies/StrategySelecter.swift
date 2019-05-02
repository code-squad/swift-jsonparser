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
    
    
    
    private mutating func detectType(_ character: Character) throws -> ParsingState {
        if character == " " { return ParsingState.isNotDone }
        
        
        
        throw TypeSeltectionError.unsupportedCharacter
    }
    
}

enum TypeSeltectionError: Error {
    case unsupportedCharacter
}
