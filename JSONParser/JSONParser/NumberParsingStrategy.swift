import Foundation

struct NumberParsingStrategy: ParsingStrategy {
    
    private var buffer = ""
    private var hasDoneMinusDetection = false
    private var firstNumberDetected = false
    
    private var absoluteValueLessThanOne = false
    private var decimalPointPlaced = false
    
    
    mutating func parse(_ character: Character) throws -> ParsingState {
        if firstNumberDetected {
            return try appendToBuffer(character)
        } else if hasDoneMinusDetection {
            try detectFirstNumber(character)
        } else {
            detectMinusSign(character)
        }
        return ParsingState.isNotDone
    }
    
    private mutating func detectMinusSign(_ character: Character) {
        if character == "-" { buffer.append(character) }
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
        firstNumberDetected = true
        buffer.append(character)
    }
    
    private mutating func appendToBuffer(_ character: Character) throws -> ParsingState {
        switch character {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if absoluteValueLessThanOne { throw NumberParsingError.invalidNumberAfterZero }
        case ".":
            if decimalPointPlaced { throw NumberParsingError.duplicatedDecimalPoint }
            decimalPointPlaced = true
        default:
            guard let result = Double(buffer) else {
                throw NumberParsingError.resultCouldNotConvertedToNumbers
            }
            return ParsingState.isDonePreviousCharacter(result: Type.number(result))
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
}
