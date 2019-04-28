import Foundation

struct JSONParser: Parser {
    
    private static var currentParser: Parser = NumberParser()
    private static var didRunFirstParse = false
    
    static func parse(_ character: Character) throws -> SupportedType? {
        return 0
    }
    
    private static func firstParse(_ character: Character) throws {
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
    
    private static func secondParse(_ character: Character) throws -> SupportedType? {
        
    }
    
}

enum JSONParsingError: Error {
    case unsupportedCharacter
}
