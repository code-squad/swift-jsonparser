import Foundation

protocol ParsingStrategy {
    
    mutating func result() throws -> Type
    
    /// 문자를 분석하고 결과를 저장합니다.
    ///
    /// - Parameter character: JSON 문자입니다.
    /// - Returns: 분석이 진행중인지, 이전 글자가 마지막인지, 현재 글자가 마지막인지에 대한 상태입니다. 완료된 경우라면 결과도 반환합니다.
    /// - Throws: 분석 중 올바르지 않은 문자를 발견한 경우입니다.
    mutating func parse(_ character: Character) throws -> ParsingState
    
}
