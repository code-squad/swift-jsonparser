import Foundation

struct FormatValidator {
    
    private static let arrayPattern = "^(((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+)(\\s*,\\s*((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+))*)?$"
    private static let objectPattern = "^((\"[^\"]*\")\\s*:\\s*((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+)(\\s*,\\s*(\"[^\"]*\")\\s*:\\s*((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+))*)?$"
    
    private static var arrayRegularExpression = try! NSRegularExpression(pattern: arrayPattern, options: [])
    
    private static var objectRegularExpression = try! NSRegularExpression(pattern: objectPattern, options: [])
    
    /// 양 옆 whitespace가 지워진 후 사용해야 함
    static func validateArrayFormat(_ input: String) -> Bool {
        guard let input = input.checkingAndTrimmingCharacters(begin: Token.beginArray, end: Token.endArray) else {
            return false
        }
        return arrayRegularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
    
    /// 양 옆 whitespace가 지워진 후 사용해야 함
    static func validateObjectFormat(_ input: String) -> Bool {
        guard let input = input.checkingAndTrimmingCharacters(begin: Token.beginObject, end: Token.endObject) else {
            return false
        }
        return objectRegularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
}

extension String {
    func checkingAndTrimmingCharacters(begin: Character, end: Character) -> String? {
        guard self.first == begin, self.last == end else {
            return nil
        }
        var result = self
        result.removeFirst()
        result.removeLast()
        return result
    }
}
