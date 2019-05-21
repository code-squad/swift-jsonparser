import Foundation

struct InputView {
    
    static func ask(about question: String) -> String {
        print(question)
        return (readLine() ?? "").trimmingCharacters(in: Token.whitespace)
    }
    
}
