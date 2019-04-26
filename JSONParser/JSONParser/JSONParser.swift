import Foundation

struct JSONParser {
    
    var data = Data()
    
    var currentStringIndex = 0
    
    mutating func parse(JSON: String) throws {
        
        while currentStringIndex < JSON.count - 1 {
            
            
            
        }
        
        
        
        defer {
            currentStringIndex = 0
        }
    }
    
    mutating func collectStringData() {
        
    }
    
    mutating func collectNumberData() {
        
    }
    
    mutating func collectBoolData() {
        
    }
    
}
