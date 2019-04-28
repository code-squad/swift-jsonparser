import Foundation

enum ParsingState {
    case isNotDone
    case isDoneCurrentCharacter(result: Type)
    case isDonePreviousCharacter(result: Type)
}
