import Foundation

struct ObjectParsingStrategy: ParsingStrategy {
    
    func result() throws -> Type {
        return buffer
    }
    
    private var buffer = [String: Type]()
    
    private var stringParsingStrategy = StringParsingStrategy()
    private var strategySelecter = StrategySelecter()
    
    private var hasDetectedStartCurlyBracket = false
    private var isParsingString = false
    private var isParsingValue = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if isParsingValue {
            return try appendValue(character)
        } else if isParsingString {
            try scanString(character)
        } else {
            try detectStartCurlyBracket(character)
        }
        return ParsingState.isNotDone
    }
    
    private mutating func detectStartCurlyBracket(_ character: Character) throws {
        if character == "{" {
            hasDetectedStartCurlyBracket = true
            isParsingString = true
        } else {
            throw ObjectParsingError.cannotDetectStartCurlyBracket
        }
    }
    
    
    private mutating func detectNewValue(_ character: Character) throws -> ParsingState {
        switch character {
        case " ":
            break
        case ",":
            if isParsingValue {
                throw ObjectParsingError.unexpectedComma
            } else {
                isParsingString = true
            }
        case "}":
            return ParsingState.isDoneCurrentCharacter
        default:
            break
        }
        return ParsingState.isNotDone
    }
    
    private mutating func scanString(_ character: Character) throws {
        
        if try stringParsingStrategy.parse(character) == .isDoneCurrentCharacter {
            isParsingString = false
        }
        
    }
    
    private mutating func appendValue(_ character: Character) throws -> ParsingState {
        switch try strategySelecter.parse(character) {
        case .isDoneCurrentCharacter:
            buffer[stringParsingStrategy.result() as! String] = try strategySelecter.result()
            isParsingValue = false
        case .isDonePreviousCharacter:
            buffer[stringParsingStrategy.result() as! String] = try strategySelecter.result()
            isParsingValue = false
            return try detectNewValue(character)
        case .isNotDone:
            break
        }
        return .isNotDone
    }
    
    
    
    
}

enum ObjectParsingError: Error {
    case cannotDetectStartCurlyBracket
    case unexpectedComma
}
