import Foundation

struct ArrayParsingStrategy: ParsingStrategy {
    
    private var buffer = [Type]()
    
    private var strategySelecter = StrategySelecter()
    
    private var hasDetectedStartSquareBracket = false
    private var isParsing = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if isParsing {
            try appendValue(character)
        } else if hasDetectedStartSquareBracket {
            return try detectNewValue(character)
        } else {
            try detectStartSquareBracket(character)
        }
        return ParsingState.isNotDone
    }
    
    private mutating func detectStartSquareBracket(_ character: Character) throws {
        if character == "[" {
            hasDetectedStartSquareBracket = true
            isParsing = true
        } else {
            throw ArrayParsingError.cannotDetectStartSquareBracket
        }
    }
    
    private mutating func appendValue(_ character: Character) throws {
        
        
        
        switch try strategySelecter.parse(character) {
        case .isDoneCurrentCharacter(let result):
            buffer.append(result)
        case .isDonePreviousCharacter(let result):
            buffer.append(result)
            return
        case .isNotDone:
            return
        }
        isParsing = false
    }
    
    private mutating func detectNewValue(_ character: Character) throws -> ParsingState {
        switch character {
        case " ":
            break
        case ",":
            if isParsing {
                throw ArrayParsingError.unexpectedComma
            } else {
                isParsing = true
            }
        case "]":
            let result = buffer
            return ParsingState.isDoneCurrentCharacter(result: Type.array(result))
        default:
            break
        }
        return ParsingState.isNotDone
    }
    
    
}

enum ArrayParsingError: Error {
    case cannotDetectStartSquareBracket
    case unexpectedComma
}
