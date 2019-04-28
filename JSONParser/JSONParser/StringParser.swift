import Foundation

struct StringParser: Parser {
    
    mutating func result() throws -> SupportedType {
        if isDataToParse {
            throw StringParsingError.expectedDoubleQuotationMarksToEndParsing
        }
        defer {
            buffer = ""
            isDataToParse = false
        }
        return buffer
    }
    
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
                throw StringParsingError.expectedDoubleQuotationMarksToStartParsing
            }
        }
        return isDataToParse
    }
    
}

enum StringParsingError: Error {
    case expectedDoubleQuotationMarksToStartParsing
    case expectedDoubleQuotationMarksToEndParsing
}
