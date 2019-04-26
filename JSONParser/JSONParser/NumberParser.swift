import Foundation

struct NumberParser: Parser {
    
    private(set) var result: SupportedType
    
    private var buffer = ""
    private var hasDoneFirstParse = false
    private var hasDoneSecondParse = false
    private var isZero = false
    
    private var currentParser: (Character) throws -> Bool
    
    mutating func parse(_ character: Character) throws -> Bool {
        
    }
    
    let defaultParser = { (_ character: Character) throws -> Bool in
        
    }
    
    mutating func firstParse(_ character: Character) throws {
        switch character {
        case "-":
            buffer.append(character)
        case "0":
            buffer.append(character)
            hasDoneFirstParse = true
        case "1", "2", "3", "4", "5", "6", "7", "8", "9":
            buffer.append(character)
            hasDoneFirstParse = true
        default:
            throw NumberParsingError.invalidNumberFormat
        }
    }
    
    mutating func secondParse(_ character: Character) throws -> Bool {
        switch character {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            buffer.append(character)
            return true
        case ".":
            buffer.append(character)
            return true
        case " ", ",":
            return false
        case "e", "E":
            buffer.append(character)
            return false
        default:
            throw NumberParsingError.invalidNumberFormat
        }
        
    }
    
    
    mutating func parseDecimals(_ character: Character) throws -> Bool {
        switch character {
            
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            buffer.append(character)
            return true
        case " ", ",":
            return false
        default:
            throw NumberParsingError.invalidDecimalFormat
        }
    }
    
    
    
}

enum NumberParsingError: Error {
    case invalidNumberFormat
    case invalidDecimalFormat
}
