import Foundation

let JSON = "[ 10, 21, 4, 314, 99, 0, 72 ]"
let JSON2 = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"

let a = try JSONParser.parse(JSON: JSON)



print(try JSONParser.parse(JSON: JSON2))
