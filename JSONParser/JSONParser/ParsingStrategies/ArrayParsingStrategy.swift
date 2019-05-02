import Foundation

struct ArrayParsingStrategy: ParsingStrategy {
    
    func result() -> Type {
        let result = buffer
        return result
    }
    
    private var buffer = [Type]()
    
    private var strategySelecter = StrategySelecter()
    
    private var hasDetectedStartSquareBracket = false
    private var isParsing = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if isParsing {
            return try appendValue(character)
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
    
    private mutating func appendValue(_ character: Character) throws -> ParsingState {
        
        if character == "]", buffer.isEmpty {
            return .isDoneCurrentCharacter
        }
        
        switch try strategySelecter.parse(character) {
        case .isDoneCurrentCharacter:
            buffer.append(try strategySelecter.result())
            isParsing = false
        case .isDonePreviousCharacter:
            buffer.append(try strategySelecter.result())
            isParsing = false
            return try detectNewValue(character)
        case .isNotDone:
            break
        }
        return .isNotDone
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
    case unexpectedEndOfProgram
}
