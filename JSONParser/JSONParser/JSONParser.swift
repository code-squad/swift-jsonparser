import Foundation

struct JSONParser: Parser {
    
    private var currentParser: Parser = NumberParser()
    private var didRunFirstParse = false
    
    mutating func parse(_ character: Character) throws -> SupportedType? {
        return 0
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
    
    private func secondParse(_ character: Character) throws -> SupportedType? {
        return 0
    }
    
}

enum JSONParsingError: Error {
    case unsupportedCharacter
}
