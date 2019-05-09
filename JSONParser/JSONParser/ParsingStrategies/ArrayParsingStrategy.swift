import Foundation

struct ArrayParsingStrategy: ParsingStrategy {
    
    func resultFromBuffer() -> Type {
        let result = buffer
        return result
    }
    
    private var buffer = [Type]()
    
    private var valueParser = ValueParser()
    
    private var hasDetectedStartSquareBracket = false
    private var isParsing = false
    private var hasDetectedValue: Bool {
        return valueParser.parsingStrategy != nil
    }
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        
        if isParsing {
            return try appendValue(character)
        } else if hasDetectedStartSquareBracket {
            return try detectNewValue(character)
        } else {
            try detectStartSquareBracket(character)
        }
        return .isNotDone
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
        
        if character == "]", !hasDetectedValue {
            return .isDoneCurrentCharacter
        }
        
        switch try valueParser.parse(character) {
        case .isDoneCurrentCharacter:
            buffer.append(try valueParser.resultFromBuffer())
            isParsing = false
        case .isDonePreviousCharacter:
            buffer.append(try valueParser.resultFromBuffer())
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
            return .isDoneCurrentCharacter
        default:
            break
        }
        return .isNotDone
    }
    
}

enum ArrayParsingError: Error {
    case cannotDetectStartSquareBracket
    case unexpectedComma
    case unexpectedEndOfProgram
}
