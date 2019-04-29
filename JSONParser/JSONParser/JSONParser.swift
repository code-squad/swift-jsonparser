import Foundation

enum ParsingState {
    case isNotDone
    case isDoneCurrentCharacter
    case isDonePreviousCharacter
}

struct JSONParser {
    
    static func parse(JSON: String) throws -> Type {
        var strategySelecter = StrategySelecter()
        var currentState = ParsingState.isNotDone
        for character in JSON + " " {
            currentState = try strategySelecter.parse(character)
        }
        if currentState == .isNotDone {
            throw ParsingError.JSONEndedWithoutClosureDeclaration
        }
        return try strategySelecter.result()
    }
    
}

enum ParsingError: Error {
    case JSONEndedWithoutClosureDeclaration
}
