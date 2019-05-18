import Foundation

struct Parser {
    
    func parseString(_ input: String) -> String? {
        guard input.first == "\"", input.last == "\"" else { return nil }
        var input = input
        input.removeFirst()
        input.removeLast()
        return input
    }

    func parseNumber(_ input: String) -> Number? {
        return Number(input)
    }
    
    func parseBool(_ input: String) -> Bool? {
        switch input {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }

    func parseObject(_ input: String) -> [String: Type]? {
        return
    }

    func parseArray(_ input: String) -> [Type]? {
        return
    }

    

}
