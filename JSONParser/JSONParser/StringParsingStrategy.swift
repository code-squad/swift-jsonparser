import Foundation

struct StringParsingStrategy {
    
    private var buffer = ""
    private var stringDetected = false
    private var stringEnded = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if stringEnded {
            let result = buffer
            //TODO: 속성 초기화가 필요하면 작성
            return ParsingState.isDone(result: result)
        } else if stringDetected {
            try appendString(character)
        } else {
            try detectString(character)
        }
        return ParsingState.isNotDone
    }
    
    
    private mutating func detectString(_ character: Character) throws {
        switch character {
        case "\"":
            stringDetected = true
        default:
            throw StringParsingError.cannotDetectFirstDoubleQuotationMark
        }
    }
    
    private mutating func appendString(_ character: Character) throws {
        switch character {
        case "\"":
            stringEnded = true
        default:
            buffer.append(character)
        }
    }
    
    
}

enum StringParsingError: Error {
    case cannotDetectFirstDoubleQuotationMark
}
