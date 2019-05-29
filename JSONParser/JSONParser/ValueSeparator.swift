import Foundation

extension String {
    func trimmingStructure(begin: Character, end: Character) throws -> String {
        guard self.first == begin, self.last == end else {
            throw ValueSeparatorError.invalidStructure
        }
        var result = self
        result.removeFirst()
        result.removeLast()
        return result.trimmingCharacters(in: Structure.whitespace)
    }
}

enum ValueSeparatorError: Error {
    case invalidNestedStructure
    case invalidArrayGrammar
    case invalidObjectGrammar
    case bufferIsEmpty
    case cannotFindNameSeparator
    case objectKeyShouldBeOneAndOnly
    case invalidStructure
}

struct ValueSeparator {
    
    static func separatingArray(input: String) throws -> [String] {
        let input = try input.trimmingStructure(begin: Structure.beginArray, end: Structure.endArray)
        
        guard FormatValidator.validateArrayFormat(input) else {
            throw ValueSeparatorError.invalidArrayGrammar
        }
        return try separateValues(input: input)
    }
    
    static func separatingObject(input: String) throws -> [String: String] {
        let input = try input.trimmingStructure(begin: Structure.beginObject, end: Structure.endObject)
        guard FormatValidator.validateObjectFormat(input) else {
            throw ValueSeparatorError.invalidObjectGrammar
        }
        
        let separatedInput = try separateValues(input: input)
        var result = [String: String]()
        for value in separatedInput {
            let keyAndValue = try splitKeyAndValue(keyAndValue: value)
            guard result[keyAndValue.key] == nil else {
                throw ValueSeparatorError.objectKeyShouldBeOneAndOnly
            }
            result[keyAndValue.key] = keyAndValue.value
        }
        return result
    }
    
    private static func splitKeyAndValue(keyAndValue: String) throws -> (key: String, value: String) {
        var value = keyAndValue
        var key = ""
        var isParsingKey = false
        for character in keyAndValue {
            if character == Structure.quotationMark { isParsingKey.toggle() }
            if !isParsingKey, character == Structure.nameSeparator {
                break
            }
            key.append(value.removeFirst())
        }
        guard let nameSeparatorIndex = value.firstIndex(of: Structure.nameSeparator) else {
            throw ValueSeparatorError.cannotFindNameSeparator
        }
        value.removeSubrange(value.startIndex...nameSeparatorIndex)
        
        return (key.trimmingCharacters(in: Structure.whitespace), value.trimmingCharacters(in: Structure.whitespace))
    }
    
    private static func separateValues(input: String) throws -> [String] {
        
        let input = input.trimmingCharacters(in: Structure.whitespace)
        
        if input == "" { return [] }
        
        var result = [String]()
        var buffer = ""
        
        var isParsingString = false
        var nestedArrayCount: UInt = 0
        var nestedObjectCount: UInt = 0
        
        func moveBufferToResult() throws {
            guard !buffer.isEmpty else {
                throw ValueSeparatorError.bufferIsEmpty
            }
            let whitespaceTrimmedString = buffer.trimmingCharacters(in: Structure.whitespace)
            
            result.append(whitespaceTrimmedString)
            buffer.removeAll()
        }
        
        func parse(character: Character) throws {
            switch character {
            case Structure.endArray:
                guard nestedArrayCount > 0 else {
                    throw ValueSeparatorError.invalidNestedStructure
                }
                nestedArrayCount -= 1
            case Structure.beginArray:
                nestedArrayCount += 1
            case Structure.endObject:
                guard nestedObjectCount > 0 else {
                    throw ValueSeparatorError.invalidNestedStructure
                }
                nestedObjectCount -= 1
            case Structure.beginObject:
                nestedObjectCount += 1
            case Structure.valueSeparator:
                guard nestedArrayCount == 0, nestedObjectCount == 0 else { break }
                try moveBufferToResult()
                return
            default:
                break
            }
            buffer.append(character)
        }
        
        for character in input {
            if character == Structure.quotationMark {
                isParsingString.toggle()
            } else if !isParsingString {
                try parse(character: character)
                continue
            }
            buffer.append(character)
        }
        try moveBufferToResult()
        return result
    }
}
