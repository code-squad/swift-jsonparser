import Foundation

enum ParsingState {
    case isNotDone
    case isDoneCurrentCharacter
    case isDonePreviousCharacter
}

struct JSONParser {
    
    static func parse(JSON: String) throws -> Type {
        var strategySelecter = ValueParser()
        var hasDoneParsing = false
        for character in JSON + " " {
            
            if hasDoneParsing, character == " " {
                continue
            } else if hasDoneParsing {
                throw ParsingError.endedWithRemainingCharacters
            } else if try strategySelecter.parse(character) != .isNotDone {
                hasDoneParsing = true
            }
        }
        
        if hasDoneParsing {
            return try strategySelecter.resultFromBuffer()
        } else {
            throw ParsingError.JSONEndedWithoutClosureDeclaration
        }
        
    }
    
}

enum ParsingError: Error {
    case JSONEndedWithoutClosureDeclaration
    case endedWithRemainingCharacters
}
