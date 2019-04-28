import Foundation

enum ParsingState {
    case isNotDone
    case isDone(result: SupportedType)
}
