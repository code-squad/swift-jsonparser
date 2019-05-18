import Foundation

struct Token {
    static let beginArray: Character = "["
    static let endArray: Character = "]"
    static let beginObject: Character = "{"
    static let endObject: Character = "}"
    static let nameSeparator: Character = ":"
    static let valueSeparator: Character = ","
    static let quotationMark: Character = "\""
    
    static let whitespace: CharacterSet = [" "]
}
