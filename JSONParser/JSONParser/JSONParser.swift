import Foundation

struct JSONParser: Parser {
    
    private var parsingStrategy = ParsingStrategy.none
    private var didRunFirstParse = false
    
    mutating func parse(_ character: Character) throws -> SupportedType? {
        return 0
    }
    
    private mutating func firstParse(_ character: Character) throws {
        switch character {
        case "\"":
            parsingStrategy = .string
            didRunFirstParse = true
        case "t", "f":
            parsingStrategy = .bool
            didRunFirstParse = true
        case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            parsingStrategy = .number
            didRunFirstParse = true
        default:
            throw JSONParsingError.unsupportedCharacter
        }
    }
    
    private mutating func secondParse(_ character: Character) throws -> SupportedType? {
        switch parsingStrategy {
        case .bool:
            
        case .number: <#code#>
        case .string: <#code#>
        
        case .none: <#code#>
        
            
        }
    }
    
}

enum JSONParsingError: Error {
    case unsupportedCharacter
}
