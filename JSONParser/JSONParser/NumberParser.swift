import Foundation

struct NumberParser: Parser {
    
    private static var buffer = ""
    private static var didRunFirstParse = false
    private static var isLessThanOne = false
    private static var isAfterPoint = false
    
    static func parse(_ character: Character) throws -> SupportedType? {
        if didRunFirstParse {
            return try secondParse(character)
        }
        try firstParse(character)
        return true
    }
    
    private static func firstParse(_ character: Character) throws {
        switch character {
        case "-":
            buffer.append(character)
            didRunFirstParse = true
        case "0":
            buffer.append(character)
            didRunFirstParse = true
            isLessThanOne = true
        case "1", "2", "3", "4", "5", "6", "7", "8", "9":
            buffer.append(character)
            didRunFirstParse = true
        default:
            throw NumberParsingError.invalidNumberFormat
        }
    }
    
    private static func secondParse(_ character: Character) throws -> SupportedType? {
        switch character {
        case ".":
            if isAfterPoint {
                throw NumberParsingError.duplicatedDecimalPoint
            }
            buffer.append(character)
            isAfterPoint = true
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if isLessThanOne && !isAfterPoint {
                throw NumberParsingError.invalidNumberAfterZero
            }
            buffer.append(character)
        case " ", ",":
            guard let result = Double(buffer) else {
                throw NumberParsingError.resultCouldNotConvertedToNumbers
            }
            defer {
                buffer = ""
                didRunFirstParse = false
                isLessThanOne = false
                isAfterPoint = false
            }
            return result
        default:
            throw NumberParsingError.invalidNumberFormat
        }
        return nil
    }
    
    
}

enum NumberParsingError: Error {
    case invalidNumberFormat
    case invalidNumberAfterZero
    case duplicatedDecimalPoint
    case resultCouldNotConvertedToNumbers
}
