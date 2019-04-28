import Foundation

var stringParser = StringParser()

let json = "\"ddd12313\"\"dasdad\""

for i in json {
    guard try stringParser.parse(i) else {
        break
    }
    
    
    
}

print(try stringParser.result())


let encoder = JSONEncoder()
