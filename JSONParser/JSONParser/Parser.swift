import Foundation

protocol Parser {
    
    var result: SupportedType { get }
    
    mutating func parse(_ character: Character) throws -> Bool
    
}
