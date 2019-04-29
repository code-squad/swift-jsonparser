import Foundation

enum ParsingState {
    case isNotDone
    case isDoneCurrentCharacter
    case isDonePreviousCharacter
}

struct JSONParser {
    
    static func parse(JSON: String) throws -> Type {
        var strategySelecter = StrategySelecter()
        for character in JSON {
            try strategySelecter.parse(character)
        }
        return try strategySelecter.result()
    }
    
}
