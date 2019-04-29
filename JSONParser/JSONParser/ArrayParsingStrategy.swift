import Foundation

struct ArrayParsingStrategy: ParsingStrategy {
    
    var result: Type {
        let result = buffer
        return Type.array(result)
    }
    
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
        case .isDoneCurrentCharacter:
            buffer.append(strategySelecter.result)
        case .isDonePreviousCharacter:
            buffer.append(strategySelecter.result)
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
            return ParsingState.isDoneCurrentCharacter
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
