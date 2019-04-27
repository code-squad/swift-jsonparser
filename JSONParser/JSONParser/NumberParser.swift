import Foundation

struct NumberParser: Parser {
    
    private(set) var result: SupportedType
    private var buffer = ""
    private var didRunFirstParse = false
    private var isLessThanOne = false
    private var isAfterPoint = false
    
    mutating func parse(_ character: Character) throws -> Bool {
        return true
    }
    
    mutating func firstParse(_ character: Character) throws {
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
    
    mutating func secondParse(_ character: Character) throws -> Bool {
        switch character {
        case ".":
            buffer.append(character)
            isAfterPoint = true
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            buffer.append(character)
        case " ", ",":
            return false
        default:
            throw NumberParsingError.invalidNumberFormat
        }
        return true
    }
    
    mutating func thridParse(_ character: Character) throws -> Bool {
        switch character {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            buffer.append(character)
        case " ", ",":
            return false
        default:
            throw NumberParsingError.invalidNumberFormat
        }
        return true
    }
    
}

enum NumberParsingError: Error {
    case invalidNumberFormat
}
