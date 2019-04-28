import Foundation

var jsonParser = BoolParser()

let json = "false1"

for i in json {
    print(try jsonParser.parse(i))
}
