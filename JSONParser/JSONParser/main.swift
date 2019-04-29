import Foundation

let JSON = "[ 10, 21, 4, 314, 99, 0, 72 ]"
let JSON2 = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"

let aaaa = try JSONParser.parse(JSON: JSON2)

print(aaaa)

//print(try JSONParser.parse(JSON: "false"))

//let b = Type.bool(true)
//print(b)

