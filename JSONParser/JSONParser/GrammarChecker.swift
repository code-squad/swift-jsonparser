import Foundation

struct GrammarChecker {
    
    private static let arrayPattern = "^\\[\\s*(((\".*\"|[^,\"\\s]+)\\s*)(,\\s*(\".*\"|[^,\"\\s]+)\\s*)*)?\\]$"
    private static let objectPattern = "^\\{\\s*(((\"[^\"]*\")\\s*:\\s*(\"[^\"]*\"|[^,\"\\s]+)\\s*)(,\\s*((\"[^\"]*\")\\s*:\\s*(\"[^\"]*\"|[^,\"\\s]+))\\s*)*)?\\}$"
    
    private static var arrayRegularExpression = try! NSRegularExpression(pattern: arrayPattern, options: [])
    
    private static var objectRegularExpression = try! NSRegularExpression(pattern: objectPattern, options: [])
    
    static func validateArrayGrammar(_ input: String) -> Bool {
        return arrayRegularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
    
    static func validateObjectGrammar(_ input: String) -> Bool {
        return objectRegularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
    
}
