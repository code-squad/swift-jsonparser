import Foundation

struct Parser {
    
    func parseString(_ input: String) -> String? {
        guard input == "\"" else { return nil }
        var input = input
        input.removeFirst()
        input.removeLast()
        return input
    }

    func parseNumber(_ input: String) -> Number? {
        return 0
    }

    func parseObject(_ input: String) -> [String: Type]? {
        return
    }

    func parseArray(_ input: String) -> [Type]? {
        return
    }

    func parseBool(_ input: String) -> Bool? {
        return
    }

}
