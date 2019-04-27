import Foundation

struct StringParser: Parser {
    
    private(set) var result: SupportedType
    private var buffer = ""
    private var isDataToParse = false
    
    mutating func parse(_ character: Character) throws -> Bool {
        switch character {
        case "\"":
            isDataToParse.toggle()
        default:
            if isDataToParse {
                buffer.append(character)
            } else {
                throw StringParsingError.expectedDoubleQuotationMarks
            }
        }
        return isDataToParse
    }
    
}

enum StringParsingError: Error {
    case expectedDoubleQuotationMarks
}
