import Foundation

enum ParsingState {
    case isNotDone
    case isDoneCurrentCharacter
    case isDonePreviousCharacter
}

struct JSONParser {
    
    static func parse(JSON: String) throws -> Type {
        var strategySelecter = StrategySelecter()
        
        for character in JSON + " " {
            if try strategySelecter.parse(character) != .isNotDone {
                return try strategySelecter.result()
            }
        }
        
        throw ParsingError.JSONEndedWithoutClosureDeclaration
        
    }
    
}

enum ParsingError: Error {
    case JSONEndedWithoutClosureDeclaration
}
