import Foundation

struct InputView {
    
    static func ask(about question: String) throws -> String {
        print(question)
        guard let input = readLine() else {
            throw InputError.invalidError
        }
        return input
    }
    
}

enum InputError: Error {
    case invalidError
}
