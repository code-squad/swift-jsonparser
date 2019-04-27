import Foundation

protocol SupportedType { }
extension String: SupportedType { }
extension Double: SupportedType { }
extension Bool: SupportedType { }

struct JSONParser {
    
    var data = Data()
    
    var isDataToParse = false
    

    
    
}


enum ArrayParsingError: Error {
    case squareBracketWasOpenedIncorrectly
    case squareBracketWasClosedIncorrectly
}


