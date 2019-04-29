import Foundation

struct NumberParsingStrategy: ParsingStrategy {
    
    func result() throws -> Type {
        guard let result = Double(buffer) else {
            throw NumberParsingError.resultCouldNotConvertedToNumbers
        }
        return result
    }
    
    private var buffer = ""
    
    private var hasDoneMinusDetection = false
    private var hasDetectedMinusSign = false
    
    private var hasDetectedFirstNumber = false
    
    private var absoluteValueLessThanOne = false
    private var decimalPointPlaced = false
    
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if !hasDoneMinusDetection {
            detectMinusSign(character)
            if hasDetectedMinusSign {
                return ParsingState.isNotDone
            }
        }
        if hasDetectedFirstNumber {
            return try appendToBuffer(character)
        } else {
            try detectFirstNumber(character)
            return ParsingState.isNotDone
        }
    }
    
    private mutating func detectMinusSign(_ character: Character) {
        if character == "-" {
            buffer.append(character)
            hasDetectedMinusSign = true
        }
        hasDoneMinusDetection = true
    }
    
    private mutating func detectFirstNumber(_ character: Character) throws {
        switch character {
        case "0":
            absoluteValueLessThanOne = true
        case "1", "2", "3", "4", "5", "6", "7", "8", "9":
            break
        default:
            throw NumberParsingError.invalidNumberFormat
        }
        hasDetectedFirstNumber = true
        buffer.append(character)
    }
    
    private mutating func appendToBuffer(_ character: Character) throws -> ParsingState {
        switch character {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if absoluteValueLessThanOne { throw NumberParsingError.invalidNumberAfterZero }
        case ".":
            if decimalPointPlaced { throw NumberParsingError.duplicatedDecimalPoint }
            decimalPointPlaced = true
        case " ", ",":
            return ParsingState.isDonePreviousCharacter
        default:
            throw NumberParsingError.invalidCharacter
        }
        buffer.append(character)
        return ParsingState.isNotDone
    }
    
}

enum NumberParsingError: Error {
    case invalidNumberFormat
    case invalidNumberAfterZero
    case duplicatedDecimalPoint
    case resultCouldNotConvertedToNumbers
    case invalidCharacter
}
