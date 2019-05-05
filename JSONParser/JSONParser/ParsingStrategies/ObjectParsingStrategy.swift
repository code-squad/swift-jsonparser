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
    private var isParsingColon = false
    private var isParsingValue = false
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if isParsingValue {
            return try scanValue(character)
        } else if isParsingString {
            return try scanString(character)
        } else if isParsingColon {
            try scanColon(character)
        } else if hasDetectedStartCurlyBracket {
            return try detectNewValue(character)
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
            return .isDoneCurrentCharacter
        default:
            break
        }
        return ParsingState.isNotDone
    }
    
    private mutating func scanString(_ character: Character) throws -> ParsingState {
        
        if character == "}", buffer.isEmpty {
            return .isDoneCurrentCharacter
        }
        
        if try stringParsingStrategy.parse(character) == .isDoneCurrentCharacter {
            isParsingString = false
            isParsingColon = true
        }
        return .isNotDone
    }
    
    private mutating func scanColon(_ character: Character) throws {
        
        switch character {
        case " ":
            return
        case ":":
            isParsingColon = false
            isParsingValue = true
        default:
            throw ObjectParsingError.expectedColon
        }
        
    }
    
    private mutating func scanValue(_ character: Character) throws -> ParsingState {
        
        switch try strategySelecter.parse(character) {
        case .isDoneCurrentCharacter:
            buffer[try stringParsingStrategy.result() as! String] = try strategySelecter.result()
            isParsingValue = false
        case .isDonePreviousCharacter:
            buffer[try stringParsingStrategy.result() as! String] = try strategySelecter.result()
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
    case expectedColon
}
