import Foundation

struct BoolParsingStrategy: ParsingStrategy {
    
    func result() -> Type {
        return resultBool
    }
    
    private var boolCharacters = [Character]()
    private var hasDetectedBool = false
    
    private var resultBool = false
    
    
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if hasDetectedBool {
            return try matchBoolCharacters(character)
        } else {
            try detectBool(character)
        }
        return ParsingState.isNotDone
    }
    
    
    private mutating func detectBool(_ character: Character) throws {
        switch character {
        case "t":
            boolCharacters = ["r", "u", "e"]
            resultBool = true
        case "f":
            boolCharacters = ["a", "l", "s", "e"]
            resultBool = false
        default:
            throw BoolParsingError.cannotFindBoolFormat
        }
        hasDetectedBool = true
    }
    
    private mutating func matchBoolCharacters(_ character: Character) throws -> ParsingState {
        if character == boolCharacters.first {
            boolCharacters.removeFirst()
            if boolCharacters.isEmpty { return ParsingState.isDoneCurrentCharacter }
            return ParsingState.isNotDone
        }
        throw BoolParsingError.doesNotMatchBoolCharacters
    }
    
}

enum BoolParsingError: Error {
    case cannotFindBoolFormat
    case doesNotMatchBoolCharacters
}
