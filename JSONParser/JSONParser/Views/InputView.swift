import Foundation

struct InputView {
    
    static func show(_ string: String) {
        print(string)
    }
    
    static func ask(_ something: String = "입력값") -> String {
        print("\(something): ", terminator: "")
        return (readLine() ?? "").trimmingCharacters(in: Structure.whitespace)
    }
    
}
