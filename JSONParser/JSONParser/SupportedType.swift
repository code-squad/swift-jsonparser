import Foundation

enum Type {
    case string(String)
    case number(Double)
    case bool(Bool)
    indirect case array(Array<Type>)
}
