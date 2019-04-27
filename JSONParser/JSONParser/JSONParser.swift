import Foundation

protocol SupportedType { }
extension String: SupportedType { }
extension Double: SupportedType { }
extension Bool: SupportedType { }

struct JSONParser {
    
    var data = Data()
    
    func parse(_ character: Character) {
        <#function body#>
    }
    
    
}


enum ArrayParsingError: Error {
    case squareBracketWasOpenedIncorrectly
    case squareBracketWasClosedIncorrectly
}


