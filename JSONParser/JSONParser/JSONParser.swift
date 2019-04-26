import Foundation

enum Type {
    case string
    case number
    case bool
}

struct JSONParser {
    
    var data = Data()
    
    var isDataToParse = false
    
    mutating func parse(character: Character) throws {
        switch character {
        case "[":
            if isDataToParse {
                throw ArrayParsingError.squareBracketWasOpenedIncorrectly
            } else {
                isDataToParse = !isDataToParse
            }
        case "]":
            if isDataToParse {
                isDataToParse = !isDataToParse
            } else {
                throw ArrayParsingError.squareBracketWasClosedIncorrectly
            }
        case ",", " ":
            return
        default:
            //TODO: 첫글자에 따라 분석기 선택하기
        }
    }
    
    func selectParser(character: Character) -> <#return type#> {
        <#function body#>
    }
    
    
    
    struct StringParser {
        var buffer = ""
        var isDataToParse = false
        var isEscapeSequence = false
        
        mutating func parse(character: Character) {
            switch character {
            case "\\":
                if isEscapeSequence {
                    buffer.append(character)
                } else {
                    isEscapeSequence = !isEscapeSequence
                }
            case "\"":
                if isEscapeSequence {
                    buffer.append(character)
                    isEscapeSequence = !isEscapeSequence
                } else {
                    isDataToParse = !isDataToParse
                }
            default:
                if isDataToParse {
                    buffer.append(character)
                } else {
                    return buffer
                }
            }
            return nil
        }
    }
    
    
    
    struct NumberParser {
        var buffer = ""
        var isDataToParse = false
        var hasMinusSign = false
        var isZero = false
        
        mutating func parse(character: Character) throws -> Double? {
            switch character {
            case "-":
                if hasMinusSign {
                    throw NumberParsingError.duplicatedMinusSign
                } else {
                    hasMinusSign = !hasMinusSign
                    buffer.append(character)
                }
            case "0":
                if isZero {
                    throw NumberParsingError.duplicatedNumberZero
                } else {
                    isZero = !isZero
                }
            default:
                buffer.append(character)
            }
            
            return nil
        }
        
    }
    
    
    
}


enum ArrayParsingError: Error {
    case squareBracketWasOpenedIncorrectly
    case squareBracketWasClosedIncorrectly
}

enum NumberParsingError: Error {
    case duplicatedMinusSign
    case duplicatedNumberZero
    case invalidNumber
}
