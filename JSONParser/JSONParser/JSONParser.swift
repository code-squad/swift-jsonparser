import Foundation

struct JSONParser {
    
    var data = Data()
    
    
    
    mutating func parse(JSON: String) throws {
        
        var currentEncodedOffset = 0
        var currentStringIndex = String.Index(encodedOffset: currentEncodedOffset)
        
        
        func collectStringData() {
            var string = ""
            while currentEncodedOffset < JSON.count - 1 {
                if JSON[currentStringIndex] == "\"" {
                    break
                }
                string.append(JSON[currentStringIndex])
                currentEncodedOffset += 1
            }
            data.string.append(string)
        }
        
        
        func collectNumberData() {
            while currentEncodedOffset < JSON.count - 1 {
                
                
                currentEncodedOffset += 1
            }
            
        }
        
        
        func collectBoolData() {
            while currentEncodedOffset < JSON.count - 1 {
                
                
                currentEncodedOffset += 1
            }
            
        }
        
        
        while currentEncodedOffset < JSON.count - 1 {
            switch JSON[currentStringIndex] {
            case "[":
                ""
            default:
                ""
            }
            
            
            
            currentEncodedOffset += 1
        }
        
        
        
        
        
        
        
        
        
        defer {
            currentEncodedOffset = 0
        }
        
        
        
        
    }
    
    
    
}
