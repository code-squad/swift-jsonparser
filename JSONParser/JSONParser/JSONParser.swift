import Foundation

struct JSONParser: Parser {
    
    private var currentParser: Parser = NumberParser()
    private var didRunFirstParse = false
    
    mutating func parse(_ character: Character) throws -> SupportedType? {
        if didRunFirstParse {
            return try secondParse(character)
        }
        try firstParse(character)
        return nil
    }
    
    private mutating func firstParse(_ character: Character) throws {
        switch character {
        case "\"":
            currentParser = StringParser()
            didRunFirstParse = true
        case "t", "f":
            currentParser = BoolParser()
            didRunFirstParse = true
        case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            currentParser = NumberParser()
            didRunFirstParse = true
        default:
            throw JSONParsingError.unsupportedCharacter
        }
    }
    
    private mutating func secondParse(_ character: Character) throws -> SupportedType? {
        if let result = try currentParser.parse(character) {
            return result
        }
        return nil
    }
    
}

enum JSONParsingError: Error {
    case unsupportedCharacter
}
