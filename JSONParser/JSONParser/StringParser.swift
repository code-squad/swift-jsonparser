import Foundation

struct StringParser: Parser {
    
    private static var buffer = ""
    private static var isDataToParse = false
    
    static func parse(_ character: Character) throws -> SupportedType? {
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
        guard isDataToParse else {
            let result = buffer
            buffer = ""
            return result
        }
        return nil
    }
    
}

enum StringParsingError: Error {
    case expectedDoubleQuotationMarksToStartParsing
    case expectedDoubleQuotationMarksToEndParsing
}
