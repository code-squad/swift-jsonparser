import Foundation

struct GrammarChecker {
    
    private static let pattern = "^\\[\\s*(((\".*\"|[^,\"\\s]+)\\s*)(,\\s*(\".*\"|[^,\"\\s]+)\\s*)*)?\\]$|^\\{\\s*(((\"[^\"]*\")\\s*:\\s*(\"[^\"]*\"|[^,\"\\s]+)\\s*)(,\\s*((\"[^\"]*\")\\s*:\\s*(\"[^\"]*\"|[^,\"\\s]+))\\s*)*)?\\}$"
    
    private static var regularExpression = try! NSRegularExpression(pattern: pattern, options: [])
    
    static func checkJSONGrammar(_ input: String) -> Bool {
        return regularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
    
}
