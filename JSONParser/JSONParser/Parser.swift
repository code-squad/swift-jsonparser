import Foundation

protocol Parser {
    
    var buffer: String { get }
    var isDataToParse: Bool { get }
    
}
