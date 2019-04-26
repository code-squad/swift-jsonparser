import Foundation

enum Type {
    case string
    case number
    case bool
}

struct JSONParser {
    
    var data = Data()
    
    var isDataToParse = false
    
    mutating func parse(character: Character) throws {
        switch character {
        case "[":
            if isDataToParse {
                throw ArrayParsingError.squareBracketWasOpenedIncorrectly
            } else {
                isDataToParse = !isDataToParse
            }
        case "]":
            if isDataToParse {
                isDataToParse = !isDataToParse
            } else {
                throw ArrayParsingError.squareBracketWasClosedIncorrectly
            }
        case ",", " ":
            return
        default:
            //TODO: 첫글자에 따라 분석기 선택하기
        }
    }
    
    func selectParser(character: Character) -> <#return type#> {
        <#function body#>
    }
    
    
    

    
    
    

    
    
    
}


enum ArrayParsingError: Error {
    case squareBracketWasOpenedIncorrectly
    case squareBracketWasClosedIncorrectly
}


