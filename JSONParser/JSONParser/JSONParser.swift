import Foundation

struct JSONParser {
    
    var data = Data()
    
    
    
    mutating func parse(JSON: String) throws {
        
        var currentEncodedOffset = 0
        var currentStringIndex = String.Index(encodedOffset: currentEncodedOffset)
        
        
        
        
        func collectStringData(firstCharacter: Character) {
            var string = "\(firstCharacter)"
            while currentEncodedOffset < JSON.count - 1 {
                if JSON[currentStringIndex] == "\"" {
                    currentEncodedOffset += 1
                    break
                }
                string.append(JSON[currentStringIndex])
                currentEncodedOffset += 1
            }
            data.string.append(string)
        }
        
        
        func collectNumberData(firstCharacter: Character) throws {
            let digits: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            var numberString = "\(firstCharacter)"
            
            if numberString == "0", JSON[currentStringIndex] == "0" {
                throw ParsingError.invalidNumber
            }
            
            
            if JSON[currentStringIndex] == "-" {
                numberString.append(JSON[currentStringIndex])
                currentEncodedOffset += 1
            }
            
            
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

enum ParsingError: Error {
    case invalidNumber
}
