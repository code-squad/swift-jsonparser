import Foundation

struct StringParser: Parser {
    
    private var buffer = ""
    private var isDataToParse = false
    
    mutating func parse(_ character: Character) throws -> SupportedType? {
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
