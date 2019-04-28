import Foundation

enum ParsingState {
    case isNotDone
    case isDoneCurrentCharacter(result: SupportedType)
    case isDonePreviousCharacter(result: SupportedType)
}
