import Foundation

protocol Type { }

extension String: Type { }
extension Double: Type { }
extension Bool: Type { }
extension Array: Type where Element == Type { }

