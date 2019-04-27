import Foundation

struct ArrayParser: Parser {
    func result() throws -> SupportedType {
        <#code#>
    }
    
    func parse(_ character: Character) throws -> Parser {
        switch character {
        case "[":
            return self
        case "]":
            return self
        default:
            <#code#>
        }
    }
    
    
}

enum ArrayParsingError: Error {
    case squareBracketWasOpenedIncorrectly
    case squareBracketWasClosedIncorrectly
}
