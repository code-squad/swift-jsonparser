import Foundation

struct ValueParser {
    
//    var arrayParser = ArrayParser()
    var boolParser = BoolParser()
    var stringParser = StringParser()
    var numberParser = NumberParser()
    
    func parse(_ character: Character) throws -> Parser? {
        switch character {
        case "\"":
            return stringParser
        case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            return numberParser
//        case "[":
//            return arrayParser
        case "t", "f":
            return boolParser
        case " ":
            return nil
        default:
            throw ValueParsingError.invalidCharacter
        }
    }
    
}

enum ValueParsingError: Error {
    case invalidCharacter
}
