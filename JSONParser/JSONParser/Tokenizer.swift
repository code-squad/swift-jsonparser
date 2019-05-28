import Foundation

struct Tokenizer {
    
    static func tokenize(input: String) -> [String] {
        
        var result = [String]()
        var buffer = ""
        
        func moveExistingBufferToResult() {
            if !buffer.isEmpty {
                result.append(buffer)
                buffer.removeAll()
            }
        }
        
        for character in input {
            if Structure.tokens.contains(character) {
                moveExistingBufferToResult()
                result.append(String(character))
            } else {
                buffer.append(character)
            }
        }
        moveExistingBufferToResult()
        return result
    }
    
}
