import Foundation

struct ObjectParsingStrategy: ParsingStrategy {
    
    func result() throws -> Type {
        <#code#>
    }
    
    private var buffer = [String: Type]()
    
    private var stringParsingStrategy = StringParsingStrategy()
    private var strategySelecter = StrategySelecter()
    
    private var hasDetectedStartCurlyBracket = false
    private var isParsingString = false
    private var isParsingValue = false
    
    func parse(_ character: Character) throws -> ParsingState {
        <#code#>
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
                throw ArrayParsingError.unexpectedComma
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
    
    
    
    
}

enum ObjectParsingError: Error {
    case cannotDetectStartCurlyBracket
}
