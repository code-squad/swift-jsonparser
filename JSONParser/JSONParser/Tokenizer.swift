import Foundation

struct Tokenizer {
    
    struct Token {
        static let beginArray = "["
        static let endArray = "]"
        static let beginObject = "{"
        static let endObject = "}"
        static let nameSeparator = ":"
        static let valueSeparator = ","
        static let quotationMark = "\""
        
        static let whitespace = " "
    }
    
    func tokenize(_ input: String) -> [String] {
        
    }
    
    private func tokenizeArray(_ input: String) -> [String] {
        
    }
    
    private func tokenizeObject(_ input: String) -> String {
        
    }
    
}




