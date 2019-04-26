import Foundation

struct NumberParser: Parser {
    
    var result: SupportedType
    
    var buffer = ""
    var isDataToParse = false
    var hasDoneFirstParse = false
    var isZero = false
    
    mutating func parse(_ character: Character) throws -> Bool {
        
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
    
    mutating func secondParse(_ character: Character) throws {
        switch <#value#> {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
        
    }
    
    
    
}

enum NumberParsingError: Error {
    case duplicatedMinusSign
    case duplicatedNumberZero
    case invalidNumberFormat
}
