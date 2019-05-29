import Foundation

struct FormatValidator {
    
    private static let arrayPattern = "^(((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+)(\\s*,\\s*((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+))*)?$"
    private static let objectPattern = "^((\"[^\"]*\")\\s*:\\s*((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+)(\\s*,\\s*(\"[^\"]*\")\\s*:\\s*((\"[^\"]*\")|(\\[.*\\])|(\\{.*\\})|[^,\\[\\]\\{\\}\\s]+))*)?$"
    
    private static var arrayRegularExpression = try! NSRegularExpression(pattern: arrayPattern, options: [])
    
    private static var objectRegularExpression = try! NSRegularExpression(pattern: objectPattern, options: [])
    
    /// 양 옆 대괄호와 공백이 지워진 후 사용해야 함
    static func validateArrayFormat(_ input: String) -> Bool {
        return arrayRegularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
    
    /// 양 옆 중괄호와 공백이 지워진 후 사용해야 함
    static func validateObjectFormat(_ input: String) -> Bool {
        return objectRegularExpression.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) == 1
    }
}


