import Foundation

protocol SupportedType { }
extension String: SupportedType { }
extension Double: SupportedType { }
extension Bool: SupportedType { }
extension Array: SupportedType { }

struct JSONParser {
    
    var data = Data()
    
    var boolParser = BoolParser()
    var stringParser = StringParser()
    var numberParser = NumberParser()
    
    mutating func parse(JSON: String) {
        var currentParser: Parser
        
        for character in JSON {
            
        }
    }
    
}
